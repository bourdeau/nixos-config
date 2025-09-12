#!/usr/bin/env nu

try {
  let mnt = "/run/media/" + ($env.USER | default "")
  let count = if ($mnt | path exists) { (ls $mnt | length) } else { 0 }
  let icon = " "
  let tooltip = $"udiskie — mounted devices: ($count)\nLeft click: mount all\nMiddle click: open ($mnt)\nRight click: unmount all"
  { text: $icon, tooltip: $tooltip, class: "udiskie" } | to json -r | print
} catch {|e|
  { text: " ", tooltip: "udiskie status: error", class: "udiskie error" } | to json | print
}
