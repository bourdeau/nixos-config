<p align="center">
<span style="font-size: 4em; font-weight: bold;">My Nix Config</span><br/>
  <img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/footers/gray0_ctp_on_line.svg?sanitize=true" />
</p>

<p align="center">
  <a href="https://vimeo.com/1118381414">
    <img
      src="https://i.vimeocdn.com/filter/overlay?src0=https%3A%2F%2Fi.vimeocdn.com%2Fvideo%2F2058559295-1b6361da215234a0031aab54dec37d9647cbd94033a740aaebf2de1e8e0fe713-d_295x166%3Fregion%3Dus&src1=http%3A%2F%2Ff.vimeocdn.com%2Fp%2Fimages%2Fcrawler_play.png"
      alt="Watch the video"
      width="590"
    />
  </a>
</p>

## Components

|                             |                                                                                                            |
| --------------------------- | :--------------------------------------------------------------------------------------------------------- |
| **Theme**                   | [Catppuccin Mocha](https://catppuccin.com/)                                                                |
| **Display Manager**         | [SDDM](https://github.com/sddm/sddm) + [Astronaut Theme](https://github.com/Keyitdev/sddm-astronaut-theme) |
| **Window Manager**          | [Hyprland](https://hypr.land/)                                                                             |
| **Status Bar**              | [Waybar](https://github.com/Alexays/Waybar)                                                                |
| **Wallpaper Manager**       | [Hyprpaper](https://github.com/hyprwm/hyprpaper)                                                           |
| **Screen Locker**           | [Hyprlock](https://github.com/hyprwm/hyprlock)                                                             |
| **Terminal**                | [Zellij](https://zellij.dev/) + [Alacritty](https://github.com/alacritty/alacritty)                        |
| **System Resource Monitor** | [Btop](https://github.com/aristocratos/btop)                                                               |
| **File Viewer**             | [Bat](https://github.com/sharkdp/bat)                                                                      |
| **Shell**                   | [Nushell](https://www.nushell.sh/) + [Starship](https://starship.rs/)                                      |
| **Text Editor**             | [Neovim](https://neovim.io/) + [NvChad](https://nvchad.com/)                                               |
| **Fonts**                   | [Nerd Fonts](https://www.nerdfonts.com/)                                                                   |
| **Screen Recording**        | [OBS](https://obsproject.com/)                                                                             |
| **Gaming**                  | [Steam](https://store.steampowered.com/)                                                                   |
| **Chat**                    | [Discord](https://discord.com/) + [Signal](https://signal.org)                                             |
| **Web Browser**             | [Firefox](https://www.mozilla.org/firefox/)                                                                |
| **DAW**                     | [Bitwig Studio](https://www.bitwig.com/)                                                                   |
| **Secret Manager**          | [SOPS](https://github.com/Mic92/sops-nix/)                                                                 |

and a lot more...

## Help?

See `Justfile`

```console
nixos-config on  master [$!]
➜ just
Available commands:
  build <host>       - Build system for a given host
  boot <host>        - Build system for a given host, applied at next boot
  check <host>       - Dry-run build for a given host (simulate changes)
  clean              - Remove old generations, keep only the last 5
  gc                 - Garbage collect and optimise the nix store
  generations        - List all available system generations
  rollback           - Roll back to the previous generation
  test <host>        - Test configuration for a given host (temporary)
  update             - Update flake inputs
  fmt                - Auto-fix formatting and linter issues
  check-style        - Check formatting, lint, and dead code
  sync-configs       - Sync OBS and Bitwig configs from $HOME back into the nixos-config repo

Available hosts:
  phantec phzenbook
```

## Docs

[Read the docs](docs/index.md)
