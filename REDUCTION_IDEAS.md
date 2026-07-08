# Omarchy Reduction Ideas

This file tracks practical ways to shrink this Omarchy fork for an office and programming focused system.

## Next High-Value Areas

### 1. Preinstalled apps

Likely removable from `install/omarchy-base.packages` if not personally needed:

- `spotify`
- `obsidian`

These are mostly user applications, not desktop core infrastructure.

### 2. Webapps

Reduced state in `install/packaging/webapps.sh`:

- WhatsApp
- ChatGPT
- YouTube
- GitHub

Removed from this group:

- HEY
- Basecamp
- Google Photos
- Google Contacts
- Google Messages
- Google Maps
- X
- Figma
- Discord
- Zoom
- Fizzy

Matching icons and HEY/Zoom protocol handlers were removed.

### 3. TUI desktop launchers

Review `install/packaging/tuis.sh`.

Candidates:

- Disk Usage via `dua i`
- Docker via `lazydocker`

If desktop launchers are not needed, remove the installer entries. The underlying tools can still be kept separately if useful.

### 4. Optional installers

Many `bin/omarchy-install-*` commands are convenience wrappers.

Reduced state:

- Tailscale
- Chromium account setup
- JavaScript runtimes: Node.js, Bun, Deno
- Python

Removed from this group:

- Dropbox
- NordVPN
- ONCE
- alternative browser installers
- alternative terminal installers
- alternative editor installers
- language/dev environment installers outside JavaScript/Python

### 5. AI and voice

Reduced state:

- Claude Code via `claude-code`
- Codex via `@openai/codex`
- ChatGPT webapp

Removed from this group:

- non-kept AI CLIs
- voice dictation and model setup
- optional local AI installers

### 6. Capture, OCR, and transcoding

Keep screenshots if useful, but review heavier workflows:

- screen recording: `gpu-screen-recorder`, `omarchy-capture-screenrecording`, Waybar indicator
- OCR: `tesseract`, `tesseract-data-eng`, `omarchy-capture-text-extraction`
- transcoding: `omarchy-transcode`, `omarchy-transcode-ascii`, related media dependencies

Recommended default for office/dev:

- keep screenshot basics: `grim`, `slurp`, `satty`, `wl-clipboard`
- remove screen recording/OCR/transcoding if not used

### 7. Office and creative tools

Review:

- `evince`
- `sushi`
- `gnome-disk-utility`

Some are useful for office work, but they do not need to be part of a minimal base if rarely used.

### 8. Development stack

Keep only the languages and toolchains actually used.

Candidates:

- `llvm`
- `luarocks`
- `tree-sitter-cli`
- `python-poetry-core`
- `mariadb-libs`
- `postgresql-libs`
- `libyaml`

Also review:

- `bin/omarchy-install-dev-env`
- `bin/omarchy-remove-dev-env`
- development submenus in `bin/omarchy-menu`

### 9. Browser, terminal, and editor variety

Reduced state:

- browser: Chromium only
- terminal: Alacritty only

Still open:

- remove editor installers not used
- simplify default app selection commands if alternatives are removed

### 10. Packaging and ISO leftovers

Reduced state:

- legacy package availability list removed
- ArchISO-specific Chromium singleton cleanup removed

Still open as normal system decisions:

- decide whether Plymouth, Limine, and Snapper remain part of the target system

### 11. Menu-first cleanup

Use `bin/omarchy-menu` as the practical reduction map.

For every menu item removed, check for:

- related `bin/omarchy-*` command
- package in `install/omarchy-base.packages`
- config under `config/` or `default/`
- icon or `.desktop` file under `applications/`
- tests expecting the command

## Suggested Order

1. Remove preinstalled apps.
2. Reduce webapps.
3. Decide on AI and voice features.
4. Decide on capture/OCR/transcoding.
5. Reduce development stacks to actual languages.
6. Simplify browser, terminal, and editor alternatives.
7. Clean remaining package lists.
8. Re-run CLI tests and reference searches after every step.

## Verification Commands

```bash
bash test/omarchy-cli-test.sh
bash -n bin/omarchy-*
rg "removed-command-or-package" .
```
