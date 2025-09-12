# Hyprpaper Setup

This directory contains the configuration, scripts, and wallpapers for **Hyprpaper**, the wallpaper daemon for Hyprland.  
Everything is managed by **Home Manager**, meaning that wallpapers and scripts here are reproducible and automatically deployed on rebuild.

---

## How it works

- **Wallpapers directory**:  
  All images live under [`./wallpapers`](./wallpapers).  
  On rebuild, Home Manager installs them to `~/.config/hypr/wallpapers`.  
  This directory is owned by Home Manager — do not manually add or remove files there, as it will be replaced on each rebuild.

- **Hyprpaper config**:  
  [`hyprpaper.conf`](./default.nix) points Hyprpaper to `~/.config/hypr/wallpapers` and sets a default wallpaper for your monitors.

- **Random wallpaper script**:  
  [`random-wallpaper.nu`](./scripts/random-wallpaper.nu) is a [NuShell](https://www.nushell.sh/) script that:
  1. Picks a random wallpaper different from the last one.  
  2. Preloads it with `hyprctl hyprpaper preload`.  
  3. Applies it to all active monitors.  
  4. Records the chosen wallpaper so the next run avoids repeating it.  

- **Systemd integration**:  
  A user service (`random-wallpaper.service`) runs the script.  
  A timer (`random-wallpaper.timer`) triggers it every minute, so wallpapers rotate automatically.

---

## Usage

Run the script manually:

```console
~/.config/hypr/scripts/random-wallpaper.nu
```

## Attribution

All wallpapers in this directory are artworks created by [Apofiss](https://www.deviantart.com/apofiss)
