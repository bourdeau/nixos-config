<p align="center">
  <img src="docs/cats.png" alt="We don't work for cops" />
</p>

<p align="center">
    <a href="https://nixos.org/">
        <img src="https://img.shields.io/badge/NixOS-25.05-informational.svg?style=for-the-badge&logo=nixos&color=F2CDCD&logoColor=D9E0EE&labelColor=302D41"></a>
    </a>
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

|                             |                                                                                                                     |
| --------------------------- | :------------------------------------------------------------------------------------------------------------------ |
| **Theme**                   | [Catppuccin Mocha](https://catppuccin.com/)                                                                         |
| **Display Manager**         | [SDDM](https://github.com/sddm/sddm) + [Astronaut Theme](https://github.com/Keyitdev/sddm-astronaut-theme)          |
| **Window Manager**          | [Hyprland](https://hypr.land/)                                                                                      |
| **Status Bar**              | [Waybar](https://github.com/Alexays/Waybar)                                                                         |
| **Wallpaper Manager**       | [Hyprpaper](https://github.com/hyprwm/hyprpaper)                                                                    |
| **Screen Locker**           | [Hyprlock](https://github.com/hyprwm/hyprlock)                                                                      |
| **Terminal**                | [Zellij](https://zellij.dev/) + [Alacritty](https://github.com/alacritty/alacritty)                                 |
| **System Resource Monitor** | [Btop](https://github.com/aristocratos/btop)                                                                        |
| **File Viewer**             | [Bat](https://github.com/sharkdp/bat)                                                                               |
| **Shell**                   | [Nushell](https://www.nushell.sh/) + [Starship](https://starship.rs/)                                               |
| **Text Editor**             | [Neovim](https://neovim.io/) + [NvChad](https://nvchad.com/)                                                        |
| **Fonts**                   | [Nerd Fonts](https://www.nerdfonts.com/)                                                                            |
| **Screen Recording**        | [OBS](https://obsproject.com/)                                                                                      |
| **Gaming**                  | [Steam](https://store.steampowered.com/)                                                                            |
| **Chat**                    | [Discord](https://discord.com/)                                                                                     |
| **Web Browser**             | [Firefox](https://www.mozilla.org/firefox/)                                                                         |

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

Available hosts:
  phantec phcorsair phzenbook
```

## Docs

[Read the docs](docs/index.md)
