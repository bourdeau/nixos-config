#!/usr/bin/env nu
  
try {
  let home = $env.HOME
  let dir = $"($home)/.config/hypr/wallpapers"
  let state_dir = ( $env.XDG_STATE_HOME? | default $"($home)/.local/state" ) | path join "hyprpaper"
  let state_file = $state_dir | path join "last-wallpaper.txt"

  mkdir $state_dir

  let files = (ls $dir | get name)
  
  if ($files | length) == 0 {
    error make { msg: $"No wallpapers found in: ($dir)" }
  }

  let last = (if ($state_file | path exists) { (open $state_file | str trim) } else { "" })

  let candidates = ($files | where $it != $last)
  let chosen = ( (if ($candidates | length) > 0 { $candidates } else { $files }) | shuffle | first )

  let monitors = (hyprctl -j monitors | from json | get name)
  if ($monitors | length) == 0 {
    error make { msg: "No monitors returned by `hyprctl -j monitors`" }
  }

  for mon in $monitors {
    hyprctl hyprpaper wallpaper $"($mon),($chosen)"
  }

  $chosen | save -f $state_file
} catch {|e|
  notify-send "⚠️  Error hyprpaper:" $"($e.msg)"
  exit 1
}
