<h2 align="center">:snowflake: My Nix Config :snowflake:</h2>

<p align="center">
  <img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/palette/macchiato.png" width="400" />
</p>

<p align="center">
    <a href="https://nixos.org/">
        <img src="https://img.shields.io/badge/NixOS-23.11-informational.svg?style=for-the-badge&logo=nixos&color=F2CDCD&logoColor=D9E0EE&labelColor=302D41"></a>
    <a href="https://github.com/ryan4yin/nixos-and-flakes-book">
        <img src="https://img.shields.io/static/v1?label=Nix Flakes&message=learning&style=for-the-badge&logo=nixos&color=DDB6F2&logoColor=D9E0EE&labelColor=302D41"></a>
  </a>
</p>

I recently switched from Ubuntu/Arch to Nixos thanks to [Ryan4yin](https://github.com/ryan4yin) with his great [Nixos and Flakes book](https://nixos-and-flakes.thiscute.world/) ❤️

## Components

|                             |                                                                                                                     |
| --------------------------- | :------------------------------------------------------------------------------------------------------------------ |
| **Window Manager**          | [GNOME](https://www.gnome.org/)                                                                                     |
| **Terminal Emulator**       | [Zellij](https://zellij.dev/) + [Alacritty](https://github.com/alacritty/alacritty)                                 |
| **System resource monitor** | [Btop](https://github.com/aristocratos/btop)                                                                        |
| **Shell**                   | [Nushell](https://www.nushell.sh/) + [Starship](https://starship.rs/)                                               |
| **Text Editor**             | [Neovim](https://neovim.io/) + [NvChad](https://nvchad.com/)                                                        |
| **Fonts**                   | [Nerd fonts](https://www.nerdfonts.com/)                                                                            |
| **Screen Recording**        | [OBS](https://obsproject.com/)                                                                                      |

## Install

```
# Desktop
sudo nixos-rebuild switch --flake .#phcorsair

# Laptop
sudo nixos-rebuild switch --flake .#phzenbook
```

## Notes

If you try to install my config by running a command like

```
sudo nixos-rebuild --flake github:bourdeau/nios-config#phcorsair
```
**it will not work** as we quite likely don't have the same hardware.

But if you want to use my config here are the steps to follow:

```
git clone https://github.com/bourdeau/nixos-config.git ~
sudo cp /etc/nixos/hardware-configuration.nix ~/nixos-config/hosts/phcorsair/
sudo mv /etc/nixos /etc/nixos.bak
sudo ln -s ~/nixos-config/ /etc/nixos
sudo nixos-rebuild switch --flake .#phcorsair
```
