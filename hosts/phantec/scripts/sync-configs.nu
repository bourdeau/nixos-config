#!/usr/bin/env nu

let repo_dir = $"($env.HOME)/nixos-config/hosts/phantec/home"

rsync -av --delete $"($env.HOME)/.BitwigStudio/prefs/" $"($repo_dir)/bitwig-studio/config/prefs/"
rsync -av --delete $"($env.HOME)/.BitwigStudio/view-settings/" $"($repo_dir)/bitwig-studio/config/view-settings/"
rsync -av --delete $"($env.HOME)/Bitwig_Studio/Color_Palettes/" $"($repo_dir)/bitwig-studio/config/Color_Palettes/"
rsync -av --delete $"($env.HOME)/Bitwig_Studio/Controller_Scripts/" $"($repo_dir)/bitwig-studio/config/Controller_Scripts/"
rsync -av --delete --chmod=F644,D755 --no-perms --exclude-from=".gitignore" $"($env.HOME)/.config/obs-studio/" $"($repo_dir)/obs/config/"
