-- SimpleHideHUD
-- Hides parts of the default UI that Blizzard gives you no option to hide.
--
-- One file runs on every client (Retail, Forever, Classic Era, TBC Anniversary,
-- MoP Classic, Titan Reforged). Nothing here assumes a frame exists: every
-- element lists the frame names it might have on any client and only the ones
-- that are really there get used.

local ADDON_NAME = ...

local PREFIX = "|cff66ccffSimpleHideHUD|r: "
local function Print(msg)
    print(PREFIX .. msg)
end

------------------------------------------------------------------------------
-- Elements
--
-- frames:    global names, or dotted paths such as "MinimapCluster.BorderTop".
--            "%d" is expanded once per chat window.
-- transient: the game shows this only briefly by itself (banners, zone text),
--            so it is never forced back on screen when you stop hiding it.
------------------------------------------------------------------------------
local SECTIONS = {
    {
        title = "Chat",
        elements = {
            {
                key = "chat",
                label = "Chat windows",
                tip = "Hides every chat window and its tab.",
                frames = { "ChatFrame%d", "ChatFrame%dTab" },
            },
            {
                key = "chatButtons",
                label = "Chat buttons",
                tip = "Hides the chat menu, channel, voice and text to speech buttons, and the scroll buttons beside the chat window.",
                frames = {
                    "ChatFrameMenuButton", "ChatFrameChannelButton",
                    "ChatFrameToggleVoiceDeafenButton", "ChatFrameToggleVoiceMuteButton",
                    "TextToSpeechButtonFrame", "ChatFrame%dButtonFrame",
                },
            },
            {
                key = "socialButton",
                label = "Social button",
                tip = "Hides the friends (Quick Join) button next to the chat window.",
                frames = { "QuickJoinToastButton", "FriendsMicroButton" },
            },
        },
    },
    {
        title = "Bars",
        elements = {
            {
                key = "microMenu",
                label = "Micro menu",
                tip = "Hides the row of menu buttons (character, spellbook, talents, and so on). The keyboard shortcuts keep working.",
                -- MicroMenu only: its container also holds the group finder eye.
                frames = { "MicroMenu" },
            },
            {
                key = "bagsBar",
                label = "Bag bar",
                tip = "Hides the backpack and bag slot buttons. The bag keyboard shortcuts keep working.",
                frames = {
                    "BagsBar", "MainMenuBarBackpackButton", "CharacterBag0Slot", "CharacterBag1Slot",
                    "CharacterBag2Slot", "CharacterBag3Slot", "CharacterReagentBag0Slot",
                    "KeyRingButton", "BagBarExpandToggle",
                },
            },
            {
                key = "statusBars",
                label = "XP and reputation bars",
                tip = "Hides the experience, reputation and other tracking bars.",
                frames = {
                    "StatusTrackingBarManager", "MainStatusTrackingBarContainer",
                    "SecondaryStatusTrackingBarContainer", "MainMenuExpBar",
                    "ReputationWatchBar", "MainMenuBarMaxLevelBar",
                },
            },
            {
                key = "endCaps",
                label = "Action bar gryphons",
                tip = "Hides the gryphon or wyvern art at the ends of the main action bar.",
                frames = { "MainMenuBarLeftEndCap", "MainMenuBarRightEndCap" },
            },
        },
    },
    {
        title = "Minimap",
        elements = {
            {
                key = "minimap",
                label = "Whole minimap",
                tip = "Hides the minimap and everything attached to it.",
                frames = { "MinimapCluster" },
            },
            {
                key = "minimapHeader",
                label = "Zone name bar",
                tip = "Hides the zone name bar above the minimap.",
                frames = {
                    "MinimapCluster.BorderTop", "MinimapCluster.ZoneTextButton",
                    "MinimapBorderTop", "MinimapZoneTextButton", "MinimapToggleButton",
                },
            },
            {
                key = "minimapZoom",
                label = "Zoom buttons",
                tip = "Hides the minimap + and - buttons. The mouse wheel still zooms.",
                frames = { "Minimap.ZoomIn", "Minimap.ZoomOut", "MinimapZoomIn", "MinimapZoomOut" },
            },
            {
                key = "minimapCalendar",
                label = "Calendar button",
                tip = "Hides the calendar (or day and night) button on the minimap.",
                frames = { "GameTimeFrame" },
            },
            {
                key = "minimapTracking",
                label = "Tracking button",
                tip = "Hides the tracking button on the minimap.",
                frames = { "MinimapCluster.Tracking", "MiniMapTracking", "MiniMapTrackingFrame" },
            },
            {
                key = "minimapWorldMap",
                label = "World map button",
                tip = "Hides the world map button on the minimap.",
                frames = { "MiniMapWorldMapButton" },
            },
            {
                key = "minimapExpansion",
                label = "Expansion button",
                tip = "Hides the expansion landing page button on the minimap.",
                frames = { "ExpansionLandingPageMinimapButton", "GarrisonLandingPageMinimapButton" },
            },
            {
                key = "minimapAddons",
                label = "Addon drawer",
                tip = "Hides the addon compartment button on the minimap.",
                frames = { "AddonCompartmentFrame" },
            },
        },
    },
    {
        title = "Frames and messages",
        elements = {
            {
                key = "playerFrame",
                label = "Player frame",
                tip = "Hides your own portrait and health frame.",
                frames = { "PlayerFrame" },
            },
            {
                key = "objectives",
                label = "Quest tracker",
                tip = "Hides the objectives and quest tracker.",
                frames = { "ObjectiveTrackerFrame", "WatchFrame", "QuestWatchFrame" },
            },
            {
                key = "raidManager",
                label = "Raid manager tab",
                tip = "Hides the pull-out raid manager tab at the left edge of the screen.",
                frames = { "CompactRaidFrameManager" },
            },
            {
                key = "errorText",
                label = "Red error text",
                tip = "Hides the messages at the top of the screen such as \"Not enough rage\". Quest progress messages use the same area and are hidden too.",
                frames = { "UIErrorsFrame" },
            },
            {
                key = "zoneText",
                label = "Zone name popup",
                tip = "Hides the large zone name shown when you enter a new area.",
                frames = { "ZoneTextFrame", "SubZoneTextFrame" },
                transient = true,
            },
            {
                key = "eventToasts",
                label = "Level-up banners",
                tip = "Hides the banners shown in the middle of the screen for level-ups and similar events.",
                frames = { "EventToastManagerFrame", "LevelUpDisplay" },
                transient = true,
            },
            {
                key = "bossBanner",
                label = "Boss kill banner",
                tip = "Hides the banner and loot list shown after a boss dies.",
                frames = { "BossBanner" },
                transient = true,
            },
        },
    },
}

local ELEMENTS = {} -- key -> element
for _, section in ipairs(SECTIONS) do
    for _, element in ipairs(section.elements) do
        ELEMENTS[element.key] = element
    end
end

------------------------------------------------------------------------------
-- Saved settings (per character)
------------------------------------------------------------------------------
local db

local function LoadSettings()
    if type(SimpleHideHUDDB) ~= "table" then
        SimpleHideHUDDB = {}
    end
    db = SimpleHideHUDDB
    if type(db.hide) ~= "table" then
        db.hide = {}
    end
    -- Settings saved by versions before 2.0.
    if hsbhide then
        db.hide.socialButton = true
    end
    if hchide then
        db.hide.chat = true
    end
    hsbhide, hchide = nil, nil
end

local function IsHidden(key)
    return db ~= nil and db.hide[key] == true
end

------------------------------------------------------------------------------
-- Finding frames
------------------------------------------------------------------------------
local function Resolve(path)
    local object = _G
    for part in string.gmatch(path, "[^%.]+") do
        if type(object) ~= "table" then
            return nil
        end
        object = object[part]
    end
    if type(object) == "table" and object.Hide and object.Show and object.IsShown then
        return object
    end
    return nil
end

local function ForEachFrame(element, callback)
    for _, path in ipairs(element.frames) do
        if string.find(path, "%d", 1, true) then
            for i = 1, (NUM_CHAT_WINDOWS or 10) do
                local frame = Resolve(string.format(path, i))
                if frame then
                    callback(frame)
                end
            end
        else
            local frame = Resolve(path)
            if frame then
                callback(frame)
            end
        end
    end
end

local function IsAvailable(element)
    local found = false
    ForEachFrame(element, function()
        found = true
    end)
    return found
end

------------------------------------------------------------------------------
-- Hiding
--
-- A frame is hidden with a plain Hide() and kept hidden by a secure hook on
-- Show/SetShown, so the game's own code is never replaced. Protected frames
-- cannot be changed during combat; those changes wait until combat ends.
------------------------------------------------------------------------------
local tracked = {}      -- frame -> { keys = {}, transient = bool, wasShown = bool }
local pending = {}      -- frames waiting for combat to end
local suspended = false -- true while Edit Mode is open, so frames can be moved
local changing = false  -- true while this addon itself is calling Hide/Show

local function WantsHidden(info)
    if suspended then
        return false
    end
    for key in pairs(info.keys) do
        if IsHidden(key) then
            return true
        end
    end
    return false
end

local function IsLocked(frame)
    return InCombatLockdown() and frame.IsProtected ~= nil and frame:IsProtected()
end

local function Sync(frame)
    local info = tracked[frame]
    if not info then
        return
    end
    if IsLocked(frame) then
        pending[frame] = true
        return
    end
    pending[frame] = nil
    if WantsHidden(info) then
        if frame:IsShown() then
            info.wasShown = true
            changing = true
            frame:Hide()
            changing = false
        end
    elseif info.wasShown then
        info.wasShown = false
        if not info.transient then
            changing = true
            frame:Show()
            changing = false
        end
    end
end

local function Track(frame, element)
    local info = tracked[frame]
    if not info then
        info = { keys = {}, wasShown = false }
        tracked[frame] = info
        hooksecurefunc(frame, "Show", function(self)
            if not changing then
                Sync(self)
            end
        end)
        hooksecurefunc(frame, "Hide", function()
            -- The game hid it by itself, so there is nothing to bring back later.
            if not changing then
                info.wasShown = false
            end
        end)
        if frame.SetShown then
            hooksecurefunc(frame, "SetShown", function(self, shown)
                if changing then
                    return
                end
                if shown then
                    Sync(self)
                else
                    info.wasShown = false
                end
            end)
        end
    end
    info.keys[element.key] = true
    if element.transient then
        info.transient = true
    end
end

local function ApplyElement(element)
    ForEachFrame(element, function(frame)
        Track(frame, element)
        Sync(frame)
    end)
end

local function ApplyAll()
    for _, element in pairs(ELEMENTS) do
        -- Only touch frames the player asked to hide, or ones already tracked.
        if IsHidden(element.key) then
            ApplyElement(element)
        end
    end
    for frame in pairs(tracked) do
        Sync(frame)
    end
end

local function SetHidden(key, hidden)
    local element = ELEMENTS[key]
    if not element or not db then
        return
    end
    db.hide[key] = hidden and true or nil
    ApplyElement(element)
    local waiting = false
    ForEachFrame(element, function(frame)
        if pending[frame] then
            waiting = true
        end
    end)
    if waiting then
        Print(element.label .. " will change when you leave combat.")
    end
end

------------------------------------------------------------------------------
-- Hide the whole UI (press Escape to bring it back)
------------------------------------------------------------------------------
local RESTORE_BUTTON = "SimpleHideHUDRestoreButton"
local restoreButton = CreateFrame("Button", RESTORE_BUTTON)
local uiHidden = false

local function ShowUI()
    if InCombatLockdown() then
        Print("The UI cannot be shown by an addon during combat. Press Alt+Z.")
        return
    end
    ClearOverrideBindings(restoreButton)
    uiHidden = false
    UIParent:Show()
end

local function HideUI()
    if InCombatLockdown() then
        Print("The UI cannot be hidden by an addon during combat. Press Alt+Z.")
        return
    end
    uiHidden = true
    SetOverrideBindingClick(restoreButton, true, "ESCAPE", RESTORE_BUTTON)
    UIParent:Hide()
end

restoreButton:SetScript("OnClick", ShowUI)

-- If the UI comes back some other way (Alt+Z), give Escape back.
UIParent:HookScript("OnShow", function()
    if uiHidden and not InCombatLockdown() then
        uiHidden = false
        ClearOverrideBindings(restoreButton)
    end
end)

------------------------------------------------------------------------------
-- Options panel
------------------------------------------------------------------------------
local panel = CreateFrame("Frame", "SimpleHideHUDOptionsPanel")
panel.name = "SimpleHideHUD"
panel:Hide()

local categoryID
local checkboxes = {} -- key -> CheckButton
local headers = {}    -- section title -> FontString
local built = false

local COLUMN_WIDTH = 210
local COLUMNS = 3
local ROW_HEIGHT = 26

local function BuildPanel()
    built = true

    local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText("SimpleHideHUD")

    local subtitle = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -6)
    subtitle:SetText("Tick an element to hide it. Settings are saved for this character.")

    local hideAll = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    hideAll:SetSize(150, 26)
    hideAll:SetPoint("TOPLEFT", subtitle, "BOTTOMLEFT", 0, -12)
    hideAll:SetText("Hide all UI")
    hideAll:SetScript("OnClick", HideUI)

    local hint = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    hint:SetPoint("LEFT", hideAll, "RIGHT", 10, 0)
    hint:SetText("Press Escape to bring the UI back.")

    for _, section in ipairs(SECTIONS) do
        local header = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
        header:SetText(section.title)
        headers[section.title] = header

        for _, element in ipairs(section.elements) do
            local check = CreateFrame("CheckButton", nil, panel, "UICheckButtonTemplate")
            check:SetSize(24, 24)
            local text = check:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
            text:SetPoint("LEFT", check, "RIGHT", 2, 0)
            text:SetText(element.label)
            check:SetHitRectInsets(0, -(COLUMN_WIDTH - 40), 0, 0)
            check:SetScript("OnClick", function(self)
                SetHidden(element.key, self:GetChecked() and true or false)
            end)
            check:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetText(element.label, 1, 1, 1)
                GameTooltip:AddLine(element.tip, nil, nil, nil, true)
                GameTooltip:Show()
            end)
            check:SetScript("OnLeave", function()
                GameTooltip:Hide()
            end)
            checkboxes[element.key] = check
        end
    end
end

-- Lays out only the elements that exist on this client.
local function RefreshPanel()
    if not built then
        BuildPanel()
    end
    local y = -100
    for _, section in ipairs(SECTIONS) do
        local header = headers[section.title]
        local shown = 0
        for _, element in ipairs(section.elements) do
            local check = checkboxes[element.key]
            if IsAvailable(element) then
                local column = shown % COLUMNS
                local row = math.floor(shown / COLUMNS)
                check:ClearAllPoints()
                check:SetPoint("TOPLEFT", 16 + column * COLUMN_WIDTH, y - 20 - row * ROW_HEIGHT)
                check:SetChecked(IsHidden(element.key))
                check:Show()
                shown = shown + 1
            else
                check:Hide()
            end
        end
        if shown > 0 then
            header:ClearAllPoints()
            header:SetPoint("TOPLEFT", 16, y)
            header:Show()
            y = y - 20 - math.ceil(shown / COLUMNS) * ROW_HEIGHT - 12
        else
            header:Hide()
        end
    end
end

panel:SetScript("OnShow", RefreshPanel)

local function RegisterPanel()
    if Settings and Settings.RegisterCanvasLayoutCategory then
        local category = Settings.RegisterCanvasLayoutCategory(panel, panel.name)
        Settings.RegisterAddOnCategory(category)
        categoryID = category.GetID and category:GetID() or category.ID
    elseif InterfaceOptions_AddCategory then
        InterfaceOptions_AddCategory(panel)
    end
end

local function OpenOptions()
    if InCombatLockdown() then
        Print("The options panel cannot be opened during combat.")
    elseif categoryID and Settings and Settings.OpenToCategory then
        Settings.OpenToCategory(categoryID)
    elseif InterfaceOptionsFrame_OpenToCategory then
        InterfaceOptionsFrame_OpenToCategory(panel)
        InterfaceOptionsFrame_OpenToCategory(panel)
    end
end

------------------------------------------------------------------------------
-- Slash commands
------------------------------------------------------------------------------
local function FindElement(text)
    for key, element in pairs(ELEMENTS) do
        if string.lower(key) == text then
            return element
        end
    end
    return nil
end

SLASH_SIMPLEHIDEHUD1 = "/shh"
SLASH_SIMPLEHIDEHUD2 = "/simplehidehud"
SlashCmdList["SIMPLEHIDEHUD"] = function(message)
    local command = string.lower(strtrim(message or ""))
    if command == "" then
        OpenOptions()
    elseif command == "ui" then
        if uiHidden then
            ShowUI()
        else
            HideUI()
        end
    elseif command == "list" then
        Print("Elements on this client (use /shh <name> to toggle):")
        for _, section in ipairs(SECTIONS) do
            for _, element in ipairs(section.elements) do
                if IsAvailable(element) then
                    local state = IsHidden(element.key) and "|cffff6060hidden|r" or "|cff60ff60shown|r"
                    print(string.format("  %s - %s (%s)", element.key, element.label, state))
                end
            end
        end
    else
        local element = FindElement(command)
        if not element then
            Print("Unknown command. Use /shh, /shh ui, /shh list or /shh <name>.")
        elseif not IsAvailable(element) then
            Print(element.label .. " does not exist on this version of the game.")
        else
            local hidden = not IsHidden(element.key)
            SetHidden(element.key, hidden)
            Print(element.label .. (hidden and " hidden." or " shown."))
            if panel:IsShown() then
                RefreshPanel()
            end
        end
    end
end

------------------------------------------------------------------------------
-- Events
------------------------------------------------------------------------------
local function SetSuspended(value)
    suspended = value
    for frame in pairs(tracked) do
        Sync(frame)
    end
end

local events = CreateFrame("Frame")
events:RegisterEvent("ADDON_LOADED")
events:RegisterEvent("PLAYER_LOGIN")
events:RegisterEvent("PLAYER_ENTERING_WORLD")
events:RegisterEvent("PLAYER_REGEN_ENABLED")
events:SetScript("OnEvent", function(_, event, arg1)
    if event == "ADDON_LOADED" then
        if arg1 == ADDON_NAME then
            LoadSettings()
            RegisterPanel()
        elseif db then
            -- Some Blizzard frames are created by addons that load on demand.
            ApplyAll()
        end
    elseif event == "PLAYER_LOGIN" then
        -- Show everything while Edit Mode is open so frames can still be moved.
        if EditModeManagerFrame and EditModeManagerFrame.EnterEditMode then
            hooksecurefunc(EditModeManagerFrame, "EnterEditMode", function()
                SetSuspended(true)
            end)
            hooksecurefunc(EditModeManagerFrame, "ExitEditMode", function()
                SetSuspended(false)
            end)
        end
        ApplyAll()
    elseif event == "PLAYER_ENTERING_WORLD" then
        ApplyAll()
    elseif event == "PLAYER_REGEN_ENABLED" then
        for frame in pairs(pending) do
            Sync(frame)
        end
    end
end)
