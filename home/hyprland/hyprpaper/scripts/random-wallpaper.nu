#!/usr/bin/env nu

try {
  let home = $env.HOME
  let dir = $"($home)/.config/hypr/wallpapers"

  let files = (
    ls $dir
    | get name
  )

  if ($files | is-empty) {
    error make { msg: $"No wallpapers found in: ($dir)" }
  }

  let chosen = $files | shuffle | first

  let monitors = (
    hyprctl -j monitors
    | from json
    | get name
  )

  if ($monitors | is-empty) {
    error make { msg: "No monitors returned by `hyprctl -j monitors`" }
  }

  for mon in $monitors {
    hyprctl hyprpaper wallpaper $"($mon),($chosen)"
  }
} catch {|e|
  notify-send "⚠ Error hyprpaper:" ($e.msg | default "Unknown error")
  exit 1
}
