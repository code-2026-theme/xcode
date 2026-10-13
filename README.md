<p align="center">
  <img src="assets/logo.svg" alt="code-2026" width="96" />
</p>

<p align="center">
  <img src="assets/xcode.png" alt="code-2026" />
</p>

# code-2026 — Xcode

Dark and light themes for [Xcode](https://developer.apple.com/xcode/), ported from VS Code's
**Dark Modern 2026**: red keywords, purple functions, teal types and light-blue strings.

## The code-2026 family

| Target | Repository | |
| --- | --- | --- |
| Neovim | [code-2026-theme/nvim](https://github.com/code-2026-theme/nvim) | colorscheme plugin |
| Ghostty | [code-2026-theme/ghostty](https://github.com/code-2026-theme/ghostty) | terminal theme |
| kitty | [code-2026-theme/kitty](https://github.com/code-2026-theme/kitty) | terminal theme |
| Xcode | [code-2026-theme/xcode](https://github.com/code-2026-theme/xcode) | **this repo** |
| Obsidian | [code-2026-theme/obsidian](https://github.com/code-2026-theme/obsidian) | app theme |
| Yazi | [code-2026-theme/yazi](https://github.com/code-2026-theme/yazi) | file manager |
| tmux | [code-2026-theme/tmux](https://github.com/code-2026-theme/tmux) | status line |

Every port shares one palette, so the Xcode editor, `:terminal` inside Neovim and the host
terminal all render the same colors.

## Requirements

- Xcode 14 or newer (the theme format is stable well beyond that)
- macOS with SF Mono installed — it ships with Xcode. Any other font works; see
  [Fonts](#fonts).

## Install

```sh
./install.sh
```

Then **Xcode ▸ Settings ▸ Themes** and pick **code-2026** or **light-2026**. If Xcode was
open while you installed, restart it first.

<details>
<summary><b>Installer options</b></summary>

| | |
| --- | --- |
| `./install.sh` | Install, keeping a timestamped backup of any theme already there |
| `./install.sh --force` | Install, overwriting without a backup |
| `./install.sh --uninstall` | Remove the installed theme |
| `./install.sh --help` | Usage |

`XCODE_THEME_DIR` overrides the install location, which defaults to
`~/Library/Developer/Xcode/UserData/FontAndColorThemes`.

</details>

<details>
<summary><b>Manual install</b></summary>

Xcode only reads themes whose filename ends in `.xccolortheme`, so rename on the way in:

```sh
mkdir -p ~/Library/Developer/Xcode/UserData/FontAndColorThemes
cp code-2026.xccolorscheme \
  ~/Library/Developer/Xcode/UserData/FontAndColorThemes/code-2026.xccolortheme
```

That is the only thing `install.sh` does, plus a backup and a plist sanity check.

</details>

## Fonts

The theme requests **SF Mono 12** for source, **SF Pro 13** for rendered markup, italic SF
Mono for comments and bold SF Mono for `// MARK:` lines. Anything unavailable falls back to
Xcode's default font — nothing breaks.

To use a different family, select all rows in **Settings ▸ Themes** (`⌘A`) and click the
font field. Line spacing is set to `1.05`.

## Palette

The sixteen shared ANSI colors:

| | Normal | | Bright |
| --- | --- | --- | --- |
| black | `#202122` | bright black | `#555555` |
| red | `#ff7b72` | bright red | `#ffa198` |
| green | `#7ee787` | bright green | `#91eb99` |
| yellow | `#cd9731` | bright yellow | `#ffa657` |
| blue | `#79c0ff` | bright blue | `#a5d6ff` |
| magenta | `#d2a8ff` | bright magenta | `#b267e6` |
| cyan | `#4ec9b0` | bright cyan | `#71d4c0` |
| white | `#bbbebf` | bright white | `#ffffff` |

Background `#121314`, foreground `#bbbebf`, cursor `#bbbebf`, current line `#242526`,
selection `#276782`, invisibles `#555555`.

<details>
<summary><b>Syntax mapping</b></summary>

| Xcode category | Color | |
| --- | --- | --- |
| Plain text, Variables | `#bbbebf` | |
| Comments, Documentation comments | `#8b949e` | italic |
| Documentation comment keywords | `#48a0c7` | `- Parameter`, `- Returns` |
| Marks | `#8c8c8c` | bold |
| Keywords, Preprocessor statements | `#ff7b72` | `func`, `let`, `#if` |
| Attributes | `#ffa657` | `@State`, `@objc` |
| Strings, Characters | `#a5d6ff` | |
| Numbers | `#79c0ff` | |
| URLs | `#48a0c7` | |
| Type declarations, Type & class names | `#4ec9b0` | project and system |
| Other declarations, Function & method names | `#d2a8ff` | project and system |
| Constants | `#79c0ff` | project and system |
| Other class names, `self` / `super` | `#79c0ff` | |
| Macros | `#48a0c7` | `#Preview`, `#selector` |

The console and rendered markup (playgrounds, Quick Help) are themed from the same palette.

</details>

### Light palette

Background `#FFFFFF`, foreground `#202020`, cursor `#202020`, current line `#EAEAEA`,
selection `#C2DAF5`, invisibles `#606060`.

<details>
<summary><b>Light syntax mapping</b></summary>

| Xcode category | Color | |
| --- | --- | --- |
| Plain text, Variables | `#202020` | |
| Comments, Documentation comments | `#6e7781` | italic |
| Documentation comment keywords | `#0069CC` | `- Parameter`, `- Returns` |
| Marks | `#606060` | bold |
| Keywords, Preprocessor statements | `#cf222e` | `func`, `let`, `#if` |
| Attributes | `#953800` | `@State`, `@objc` |
| Strings, Characters | `#0a3069` | |
| Numbers | `#0550ae` | |
| URLs | `#0069CC` | |
| Type declarations, Type & class names | `#116329` | project and system |
| Other declarations, Function & method names | `#8250df` | project and system |
| Constants | `#0550ae` | project and system |
| Other class names, `self` / `super` | `#0550ae` | |
| Macros | `#953800` | `#Preview`, `#selector` |

</details>

## Credits

Palette from Microsoft's VS Code **Dark Modern 2026** theme, by way of
[D0nw0r/dark2026.nvim](https://github.com/D0nw0r/dark2026.nvim) (MIT).

## License

[MIT](LICENSE)
