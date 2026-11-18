# SimpleHideHUD

A small World of Warcraft addon that hides the parts of the default UI Blizzard gives you no option to hide.

## Supported game versions

One download works on all of them:

| Client | Version |
| --- | --- |
| Retail (Midnight) | 12.1.5 (12.1.7 PTR) |
| WoW: Forever | 1.60.1 |
| Classic Era, Season of Discovery, Hardcore | 1.15.9 |
| TBC Classic Anniversary | 2.5.6 |
| Mists of Pandaria Classic | 5.5.4 |
| Titan Reforged | 3.80.2 |

## What it can hide

- **Chat:** chat windows, chat buttons, the social (Quick Join / friends) button
- **Bars:** micro menu, bag bar, XP and reputation bars, action bar gryphons
- **Minimap:** the whole minimap, zone name bar, zoom buttons, calendar, tracking, world map, expansion and addon drawer buttons
- **Frames and messages:** player frame, quest tracker, raid manager tab, red error text, zone name popup, level-up banners, boss kill banner
- **Everything:** a "Hide all UI" button; press Escape to bring the UI back

Each client only lists the elements it actually has. Things Blizzard already lets you hide in Edit Mode (extra action bars, buffs, target frame, talking head and so on) are left to Edit Mode.

## Using it

Open **Options > AddOns > SimpleHideHUD**, or type `/shh`, and tick what you want hidden. Settings are saved per character.

| Command | What it does |
| --- | --- |
| `/shh` | Open the options panel |
| `/shh ui` | Hide or show the whole UI |
| `/shh list` | List the elements on this client and their names |
| `/shh <name>` | Toggle one element, for example `/shh micromenu` |

## Good to know

- Hidden elements reappear while Edit Mode is open so you can still move them.
- The game does not let addons show or hide protected frames (such as the player frame) during combat. Those changes are applied when combat ends. For the whole UI, Alt+Z works in combat.
- Hiding the red error text also hides quest progress messages, because they share the same area.

## Install

Download the zip from the [releases page](https://github.com/AndrewGBest/SimpleHideHUD/releases) and extract it into your `Interface/AddOns` folder for the client you play (`_retail_`, `_classic_era_`, `_classic_`, `_anniversary_` and so on), so that you end up with `Interface/AddOns/SimpleHideHUD/SimpleHideHUD.toc`.
