
local frame = CreateFrame("Frame", nil, UIParent)
local panel = CreateFrame("Frame", nil, UIParent)
local hsb = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate") -- HIDE SOCIAL BUTTON
local hc = CreateFrame("Button", "hcbtn", panel, "UIPanelButtonTemplate") -- HIDE CHAT
panel.name = "SimpleHideHUD"
local category, layout
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGOUT")
frame:RegisterEvent("VARIABLES_LOADED")

local timeSinceUpdate = 0
local UpdateInterval = 2
shhvloaded = false

function frame:OnEvent(event)
    if event == "ADDON_LOADED" then
        if hsbhide then
            hsb:SetText("Show Social Button")
            QuickJoinToastButton:Hide()
        end
    elseif event == "VARIABLES_LOADED" then
        shhvloaded = true
    end
end

function SHHOnUpdate(self, elapsed)
    timeSinceUpdate = timeSinceUpdate + elapsed
    if (timeSinceUpdate > UpdateInterval) and alrclick ~= true then
        if hchide and alrclick == nil and shhvloaded == true then
            alrclick = true
            onusu = true
            hcbtn:Click()
            shhvloaded = false
        elseif not hchide then
            alrclick = true
        end
    end
end

frame:HookScript("OnEvent", frame.OnEvent)
frame:HookScript("OnUpdate", function(self, elapsed) SHHOnUpdate(self, elapsed) end)

local category, layout = Settings.RegisterCanvasLayoutCategory(panel, panel.name, panel.name);
category.ID = panel.name
Settings.RegisterAddOnCategory(category);


-- HIDE ALL UI
local haui = CreateFrame("Button", "haui", panel, "UIPanelButtonTemplate")
haui:SetPoint("TOPLEFT",0,0)
haui:SetWidth(130)
haui:SetHeight(44)
haui:SetText("HIDE ALL UI")
local hauihide
haui:HookScript("OnClick", function()
    UIParent:Hide()
    hauihide = true
    SetBindingClick("ESCAPE", "haui2")
end)

local haui2 = CreateFrame("Button", "haui2", panel, "UIPanelButtonTemplate")
haui2:HookScript("OnClick", function()
    UIParent:Show()
    hauihide = false
    SetBinding("ESCAPE", "TOGGLEGAMEMENU")
end)

-- HIDE SOCIAL BUTTON
hsb:SetPoint("TOPLEFT",0,-46)
hsb:SetWidth(130)
hsb:SetHeight(22)
hsb:SetText("Hide Social Button")
hsb:HookScript("OnClick", function()
    if hsbhide == true then
        QuickJoinToastButton:Show()
        hsbhide = false
        hsb:SetText("Hide Social Button")
    elseif hsbhide == false or hsbhide == nil then
        QuickJoinToastButton:UnregisterAllEvents()
        QuickJoinToastButton:Hide()
        hsbhide = true
        hsb:SetText("Show Social Button")
    end
end)

-- HIDE CHAT
hc:SetPoint("TOPLEFT",0,-70)
hc:SetWidth(130)
hc:SetHeight(22)
hc:SetText("Hide Chat")
hc:HookScript("OnClick", function()
    _CHATHIDE = not _CHATHIDE
    for i = 1, NUM_CHAT_WINDOWS do
        for _, v in pairs {"", "Tab"} do
            local f = _G["ChatFrame" .. i .. v]
            if _CHATHIDE then
                f.v = f:IsVisible()
            end
            f.ORShow = f.ORShow or f.Show
            f.Show = _CHATHIDE and f.Hide or f.ORShow
            if f.v then
                f:Show()
            end
        end
    end

    if hchide == nil or not hchide then
        hc:SetText("Show Chat")
        hchide = true
    elseif hchide then
        hc:SetText("Hide Chat")
        if onusu then
            hc:SetText("Show Chat")
            hchide = true
            onusu = false
        elseif not onusu then
            hchide = false
        end
    end

end)