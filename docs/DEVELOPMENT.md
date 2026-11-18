# Development and release notes

## Layout

| Path | Purpose |
| --- | --- |
| `SimpleHideHUD.toc` | Addon manifest. One file covers every client through a comma-separated `## Interface` list |
| `SimpleHideHUD.lua` | All addon code |
| `LICENSE` | GNU General Public License, version 3 or later |
| `CHANGELOG.md` | User-facing changes per version |
| `docs/` | Element reference and these notes |

The `.toc`, `.lua` and `LICENSE` files ship to players. Everything else is marked `export-ignore` in `.gitattributes`, so `git archive` leaves it out of the release zip.

## How hiding works

- **Elements.** The `SECTIONS` table near the top of `SimpleHideHUD.lua` lists every element: a `key` (also its slash command name), a label and tooltip, and the frame names it may have on any client. A name can be a global (`"BagsBar"`), a dotted path (`"MinimapCluster.BorderTop"`), or contain `%d`, which expands once per chat window.
- **Runtime lookup.** Frames are resolved by name when needed. An element with no matching frame on the current client is simply not offered, which is how one file supports every client.
- **Hide and keep hidden.** A frame is hidden with a plain `Hide()`. Secure hooks on `Show`, `Hide` and `SetShown` hide it again when the game shows it, and remember whether the game itself has since hidden it, so unticking an element restores only what should be visible. Blizzard functions are never replaced.
- **Transient elements.** Banners and zone text are marked `transient`: they are suppressed while hidden but never forced back on screen.
- **Combat.** Addons may not show or hide protected frames in combat. Those frames are queued and synced on `PLAYER_REGEN_ENABLED`.
- **Edit Mode.** Hiding is suspended between `EnterEditMode` and `ExitEditMode` so frames can still be moved.
- **Typing.** The chat edit box is a child of the chat window, so hidden chat is shown again between `ChatFrameUtil.ActivateChat` and `DeactivateChat`.
- **Hide all UI.** Hides `UIParent` and binds Escape to a restore button with a temporary override binding, which is cleared when the UI returns.

Settings live in the per-character saved variable `SimpleHideHUDDB.hide[key]`. The old 1.0.2 variables `hsbhide` and `hchide` are still listed in the `.toc` so they can be migrated on first load.

## Adding an element

1. Find the frame name on each client. `/fstack` in game shows the frame under the cursor; [Gethe/wow-ui-source](https://github.com/Gethe/wow-ui-source) has the UI source for each client on its own branch (`live`, `forever`, `classic_era`, `classic_anniversary`, `classic`, `classic_titan`).
2. Check that Blizzard does not already offer a hide setting for it in Edit Mode or the options.
3. Add an entry to the right section of `SECTIONS`. List every name the frame has across clients.
4. Set `transient = true` if the game only shows it briefly by itself.
5. Add it to [ELEMENTS.md](ELEMENTS.md), the README list and the changelog.

Classic branches of the UI source share one file tree, so a frame appearing in a branch does not prove that client loads it. Follow the client's `.toc` files, including the `[Family]` and `[Game]` path placeholders and the `AllowLoadGameType` conditions, or confirm in game.

## Testing

There are no automated tests in the repository. Before a release, check in game on Retail and at least one Classic client:

1. `/shh list` shows the expected elements and no Lua errors appear (`/console scriptErrors 1`).
2. Tick every box, `/reload`, and confirm everything stays hidden.
3. Enter combat with the player frame toggled and confirm no "action blocked" message appears.
4. Open Edit Mode and confirm hidden elements return, then hide again on exit.
5. With chat hidden, press Enter and confirm chat appears while typing.
6. `/shh ui`, then Escape.
7. Untick everything and confirm the UI is back to normal.

## Updating for a new game patch

1. Find the new interface number: in game, `/dump select(4, GetBuildInfo())`.
2. Add or replace it in the `## Interface` line of `SimpleHideHUD.toc`.
3. Run the testing steps above on that client.
4. Update the version tables in the README.

## Releasing

1. Update `## Version` in `SimpleHideHUD.toc` and add a section to `CHANGELOG.md`.
2. Commit and push to `main`.
3. Tag, build the zip and publish:

```bash
git tag -a v2.0.0 -m "SimpleHideHUD v2.0.0" && git push origin v2.0.0
```

```bash
git archive --format=zip --prefix=SimpleHideHUD/ -o SimpleHideHUD-v2.0.0.zip v2.0.0
```

```bash
gh release create v2.0.0 SimpleHideHUD-v2.0.0.zip --verify-tag --title "SimpleHideHUD v2.0.0" --notes-file notes.md
```

The zip must contain a single `SimpleHideHUD/` folder with the `.toc`, `.lua` and `LICENSE` inside it.
