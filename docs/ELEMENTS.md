# Element reference

Every element SimpleHideHUD can hide, the name to use with `/shh <name>`, and the clients it exists on. Names are not case sensitive.

Availability comes from Blizzard's own UI source for each client ([Gethe/wow-ui-source](https://github.com/Gethe/wow-ui-source)), by following the list of files each client loads. The addon also checks at runtime, so the options panel and `/shh list` are always the final word for the client you are on.

"Classic" below means Classic Era, TBC Classic Anniversary, Mists of Pandaria Classic and Titan Reforged.

## Chat

| Element | Name | Retail | Forever | Classic | Notes |
| --- | --- | --- | --- | --- | --- |
| Chat windows | `chat` | Yes | Yes | Yes | Comes back while you type a message |
| Chat buttons | `chatbuttons` | Yes | Yes | Yes | Menu, channel, voice, text to speech and scroll buttons |
| Social button | `socialbutton` | Yes | Yes | Yes | Quick Join button on Retail and Forever, friends button on Classic |

## Bars

| Element | Name | Retail | Forever | Classic | Notes |
| --- | --- | --- | --- | --- | --- |
| Micro menu | `micromenu` | Yes | Yes | Yes | Shortcuts keep working. On Retail the group finder eye stays visible |
| Bag bar | `bagsbar` | Yes | Yes | Yes | Shortcuts keep working |
| XP and reputation bars | `statusbars` | Yes | Yes | Yes | |
| Action bar gryphons | `endcaps` | No | No | Yes | Retail and Forever have their own Edit Mode setting for this |

## Minimap

| Element | Name | Retail | Forever | Classic | Notes |
| --- | --- | --- | --- | --- | --- |
| Whole minimap | `minimap` | Yes | Yes | Yes | |
| Zone name bar | `minimapheader` | Yes | Yes | Yes | |
| Zoom buttons | `minimapzoom` | Yes | Yes | Yes | The mouse wheel still zooms |
| Calendar button | `minimapcalendar` | Yes | Yes | Yes | The day and night button on clients without a calendar |
| Tracking button | `minimaptracking` | Yes | Yes | Yes | |
| World map button | `minimapworldmap` | No | No | Yes | |
| Expansion button | `minimapexpansion` | Yes | Yes | No | |
| Addon drawer | `minimapaddons` | Yes | Yes | No | |

## Frames and messages

| Element | Name | Retail | Forever | Classic | Notes |
| --- | --- | --- | --- | --- | --- |
| Player frame | `playerframe` | Yes | Yes | Yes | Protected: changes wait until combat ends |
| Quest tracker | `objectives` | Yes | Yes | Yes | |
| Raid manager tab | `raidmanager` | Yes | Yes | Yes | The raid frames themselves stay visible |
| Red error text | `errortext` | Yes | Yes | Yes | Also hides quest progress messages |
| Zone name popup | `zonetext` | Yes | Yes | Yes | |
| Level-up banners | `eventtoasts` | Yes | Yes | MoP only | |
| Boss kill banner | `bossbanner` | Yes | Yes | No | |

## The whole UI

`/shh ui`, or the **Hide all UI** button in the options panel, hides everything. Press Escape to bring it back.

## What is deliberately left out

Edit Mode already has a show or hide setting for these, so the addon does not duplicate them: extra action bars, stance, pet and possess bars, buffs and debuffs, target and focus frames, party, raid, arena and boss frames, cast bar, talking head, loot frame, durability, timer bars, vehicle controls, cooldown viewer, damage meter and the personal resource display.

The main action bar is also left out, because hiding it has not been confirmed to keep its key bindings working.
