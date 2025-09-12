#!/usr/bin/env nu
  
try {
  # paths
  let home = $env.HOME
  let dir = $"($home)/Images/wallpapers"
  let state_dir = ( $env.XDG_STATE_HOME? | default $"($home)/.local/state" ) | path join "hyprpaper"
  let state_file = $state_dir | path join "last-wallpaper.txt"

  # ensure state dir exists
  mkdir $state_dir

  # collect wallpapers
  let files = (ls $dir | where type == file | get name)
  if ($files | length) == 0 {
    error make { msg: $"No wallpapers found in: ($dir)" }
  }

  # last used
  let last = (if ($state_file | path exists) { (open $state_file | str trim) } else { "" })

  # pick one that's not last; fall back if only one file
  let candidates = ($files | where $it != $last)
  let chosen = ( (if ($candidates | length) > 0 { $candidates } else { $files }) | shuffle | first )

  # preload & apply to all monitors (JSON, robust)
  hyprctl hyprpaper preload $chosen

  let monitors = (hyprctl -j monitors | from json | get name)
  if ($monitors | length) == 0 {
    error make { msg: "No monitors returned by `hyprctl -j monitors`" }
  }

  for mon in $monitors {
    hyprctl hyprpaper wallpaper $"($mon),($chosen)"
  }

  # record last used
  $chosen | save -f $state_file
} catch {|e|
  notify-send "⚠️  Error" $"($e.msg)"
  exit 1
}
