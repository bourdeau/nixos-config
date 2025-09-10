<h2 align="center">My Nix Config</h2>

<p align="center">
	<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/footers/gray0_ctp_on_line.svg?sanitize=true" />
</p>

<p align="center">
  <img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/palette/macchiato.png" width="400" />
</p>

<p align="center">
    <a href="https://nixos.org/">
        <img src="https://img.shields.io/badge/NixOS-25.05-informational.svg?style=for-the-badge&logo=nixos&color=F2CDCD&logoColor=D9E0EE&labelColor=302D41"></a>
    </a>
</p>

## Components

|                             |                                                                                                                     |
| --------------------------- | :------------------------------------------------------------------------------------------------------------------ |
| **Theme**                   | [Catppuccin Mocha](https://catppuccin.com/)                                                                         |
| **Display Manager**         | [SDDM](https://github.com/sddm/sddm) + [Astronaut Theme](https://github.com/Keyitdev/sddm-astronaut-theme)          |
| **Window Manager**          | [Hyprland](https://hypr.land/)                                                                                      |
| **Status Bar**              | [Waybar](https://github.com/Alexays/Waybar)                                                                         |
| **Wallpaper Manager**       | [Hyprpaper](https://wiki.hyprland.org/Hypr-Ecosystem/Hyprpaper/) + random rotation script                           |
| **Screen Locker**           | [Hyprlock](https://wiki.hyprland.org/Hypr-Ecosystem/Hyprlock/)                                                      |
| **Terminal Emulator**       | [Zellij](https://zellij.dev/) + [Alacritty](https://github.com/alacritty/alacritty)                                 |
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

## Install

```
# Desktop
sudo nixos-rebuild switch --flake .#phcorsair

# Laptop
sudo nixos-rebuild switch --flake .#phzenbook

# Gaming
sudo nixos-rebuild switch --flake .#phantec
```

## Update

```
nix flake update
sudo nixos-rebuild switch --flake .#phantec

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

## Recovering a Broken NixOS Boot Configuration

1. Check Available Generations

```
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
ls -l /nix/var/nix/profiles/system-*
```

2. Manually Switch to a Previous Generation

Find the correct generation in /nix/var/nix/profiles/system-XX-link and run:
```
sudo /nix/store/<corresponding-nixos-system>/bin/switch-to-configuration boot
```

Then reboot:
```
sudo reboot
```

3. Fix the System Profile Symlink

If the system boots into the correct generation but nix-env --list-generations still shows an incorrect "current" version:
```
sudo rm /nix/var/nix/profiles/system
sudo ln -s /nix/var/nix/profiles/system-XX-link /nix/var/nix/profiles/system
```

(Replace XX with the correct generation number.)

4. Rebuild and Update the Bootloader

```
sudo nixos-rebuild boot
sudo nixos-rebuild switch
```

5. Verify the Current Generation

```
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
cat /run/current-system/system-version
```

6. Clean Up Old Generations

```
sudo nix-collect-garbage -d
```

<p align="center">
	<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/footers/gray0_ctp_on_line.svg?sanitize=true" />
</p>
