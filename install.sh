#!/usr/bin/env bash
#
# dark-2026 -- Xcode installer
#
# Copies dark-2026.xccolorscheme and light-2026.xccolorscheme into Xcode's
# theme directory as .xccolortheme files, which is the extension Xcode looks for.
#
#   ./install.sh              install both themes (backs up any existing copies)
#   ./install.sh --uninstall  remove the installed themes
#   ./install.sh --help       usage

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
THEME_DIR="${XCODE_THEME_DIR:-$HOME/Library/Developer/Xcode/UserData/FontAndColorThemes}"

THEMES=("dark-2026" "light-2026")

bold=''; dim=''; red=''; green=''; yellow=''; reset=''
if [ -t 1 ]; then
  bold=$'\033[1m'; dim=$'\033[2m'; red=$'\033[31m'
  green=$'\033[32m'; yellow=$'\033[33m'; reset=$'\033[0m'
fi

info()  { printf '%s\n' "$*"; }
ok()    { printf '%s✓%s %s\n' "$green" "$reset" "$*"; }
warn()  { printf '%s!%s %s\n' "$yellow" "$reset" "$*" >&2; }
die()   { printf '%s✗%s %s\n' "$red" "$reset" "$*" >&2; exit 1; }

usage() {
  cat <<EOF
${bold}dark-2026 -- Xcode installer${reset}

Usage: install.sh [options]

Options:
  -u, --uninstall   Remove the installed themes (and nothing else)
  -f, --force       Overwrite existing themes without keeping backups
  -h, --help        Show this message

Environment:
  XCODE_THEME_DIR   Install location
                    ${dim}(default: ~/Library/Developer/Xcode/UserData/FontAndColorThemes)${reset}
EOF
}

action='install'
force=0

while [ $# -gt 0 ]; do
  case "$1" in
    -u|--uninstall) action='uninstall' ;;
    -f|--force)     force=1 ;;
    -h|--help)      usage; exit 0 ;;
    *)              usage >&2; die "unknown option: $1" ;;
  esac
  shift
done

if [ "$(uname -s)" != 'Darwin' ]; then
  die "Xcode themes only make sense on macOS (found $(uname -s))."
fi

if [ "$action" = 'uninstall' ]; then
  found=0
  for name in "${THEMES[@]}"; do
    target="$THEME_DIR/$name.xccolortheme"
    if [ -e "$target" ]; then
      rm -f "$target"
      ok "Removed $target"
      found=1
    fi
  done
  if [ "$found" -eq 1 ]; then
    info "Pick another theme in Xcode ▸ Settings ▸ Themes."
  else
    info "Nothing to do -- no dark-2026 themes are installed."
  fi
  exit 0
fi

mkdir -p "$THEME_DIR"

for name in "${THEMES[@]}"; do
  source="$SCRIPT_DIR/$name.xccolorscheme"
  target="$THEME_DIR/$name.xccolortheme"

  [ -f "$source" ] || die "theme file not found: $source"

  if command -v plutil >/dev/null 2>&1; then
    plutil -lint "$source" >/dev/null 2>&1 || die "$source is not a valid property list."
  fi

  if [ -e "$target" ]; then
    if [ "$force" -eq 1 ]; then
      rm -f "$target"
    else
      backup="$target.$(date +%Y%m%d%H%M%S).bak"
      mv "$target" "$backup"
      warn "Existing theme moved to $(basename "$backup")"
    fi
  fi

  cp "$source" "$target"
  ok "Installed $target"
done

if pgrep -xq Xcode 2>/dev/null; then
  warn "Xcode is running -- restart it before the themes show up in the list."
fi

cat <<EOF

Next: ${bold}Xcode ▸ Settings ▸ Themes${reset} and pick ${bold}dark-2026${reset} or ${bold}light-2026${reset}.
${dim}The themes set SF Mono 12; change the font in that panel to taste.${reset}
EOF
