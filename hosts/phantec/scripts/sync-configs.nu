#!/usr/bin/env nu

let repo_dir = $"($env.HOME)/nixos-config/hosts/phantec/home"

rsync -av --delete $"($env.HOME)/.BitwigStudio/prefs/" $"($repo_dir)/bitwig-studio/config/prefs/"
rsync -av --delete $"($env.HOME)/.BitwigStudio/view-settings/" $"($repo_dir)/bitwig-studio/config/view-settings/"
rsync -av --delete $"($env.HOME)/Bitwig_Studio/Color_Palettes/" $"($repo_dir)/bitwig-studio/config/Color_Palettes/"
rsync -av --delete $"($env.HOME)/Bitwig_Studio/Controller_Scripts/" $"($repo_dir)/bitwig-studio/config/Controller_Scripts/"

# OBS
rsync -av --delete --chmod=F644,D755 --exclude-from=".gitignore" $"($env.HOME)/.config/obs-studio/basic/profiles/ScreenRecord/" $"($repo_dir)/obs/config/basic/profiles/ScreenRecord/"
rsync -av --delete --chmod=F644,D755 --exclude-from=".gitignore" $"($env.HOME)/.config/obs-studio/basic/scenes/" $"($repo_dir)/obs/config/basic/scenes/"
# rsync -av --delete --chmod=F644,D755 --exclude-from=".gitignore" $"($env.HOME)/.config/obs-studio/plugin_config/obs-websocket/" $"($repo_dir)/obs/config/plugin_config/obs-websocket/"

# Easyeffects
rsync -av --delete --chmod=F644,D755 --exclude-from=".gitignore" $"($env.HOME)/.config/easyeffects/input/" $"($repo_dir)/easyeffects/config/input/"
