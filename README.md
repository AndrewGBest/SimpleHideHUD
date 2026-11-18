# SimpleHideHUD

A small World of Warcraft addon that hides the parts of the default UI Blizzard gives you no option to hide. One download works on Retail, WoW: Forever and every Classic client.

## Supported game versions

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

Each client only lists the elements it actually has; [docs/ELEMENTS.md](docs/ELEMENTS.md) shows which element is available where. Things Blizzard already lets you hide in Edit Mode (extra action bars, buffs, target frame, talking head and so on) are left to Edit Mode.

## Install

1. Download `SimpleHideHUD-<version>.zip` from the [releases page](https://github.com/AndrewGBest/SimpleHideHUD/releases).
2. Extract it into the `Interface/AddOns` folder of the client you play:

   | Client | Folder |
   | --- | --- |
   | Retail | `World of Warcraft/_retail_/Interface/AddOns` |
   | Classic Era, Season of Discovery, Hardcore | `World of Warcraft/_classic_era_/Interface/AddOns` |
   | Mists of Pandaria Classic | `World of Warcraft/_classic_/Interface/AddOns` |

   For TBC Classic Anniversary, WoW: Forever and Titan Reforged, use the `Interface/AddOns` folder inside that client's own game folder, next to the ones above.
3. You should end up with `Interface/AddOns/SimpleHideHUD/SimpleHideHUD.toc`.
4. Restart the game, or type `/reload` if it is already running.

## Using it

Open **Options > AddOns > SimpleHideHUD**, or type `/shh`, and tick what you want hidden. Settings are saved per character.

| Command | What it does |
| --- | --- |
| `/shh` | Open the options panel |
| `/shh ui` | Hide or show the whole UI |
| `/shh list` | List the elements on this client and their names |
| `/shh <name>` | Toggle one element, for example `/shh micromenu` |

`/simplehidehud` works in place of `/shh`.

## Good to know

- Hidden elements reappear while Edit Mode is open so you can still move them.
- Hidden chat reappears while you are typing a message, then hides again.
- The game does not let addons show or hide protected frames (such as the player frame) during combat. Those changes are applied when combat ends.
- Hiding the red error text also hides quest progress messages, because they share the same area.
- Hiding the micro menu or bag bar does not disable their keyboard shortcuts.

## Troubleshooting

- **The addon is listed as out of date.** A new game patch has changed the interface number. Tick "Load out of date AddOns" in the addon list, and check the releases page for an update.
- **An element is missing from the options panel.** That element does not exist on the client you are playing. `/shh list` shows what is available.
- **Something stayed hidden after unticking it.** Type `/reload`. If it still happens, please [open an issue](https://github.com/AndrewGBest/SimpleHideHUD/issues) with your game version and the element name.
- **The UI is hidden and Escape does nothing.** You are probably in combat, where addons cannot show the UI. Try Alt+Z, or wait until combat ends and press Escape again.

## License

SimpleHideHUD is free software, licensed under the [GNU General Public License v3.0](LICENSE). It comes with no warranty.

## More

- [Changelog](CHANGELOG.md)
- [Element reference](docs/ELEMENTS.md)
- [Development and release notes](docs/DEVELOPMENT.md)
