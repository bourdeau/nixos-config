#!/usr/bin/env nu

let choices = [
  { label: " Lock",    action: "uwsm app -- loginctl lock-session" }
  { label: " Suspend", action: "uwsm app -- systemctl suspend" }
  { label: " Reboot",  action: "uwsm app -- systemctl reboot" }
  { label: "⏻ Power Off", action: "uwsm app -- systemctl poweroff" }
  { label: " Logout",  action: "uwsm app -- hyprctl dispatch exit 0" }
]

let menu = $choices | get label | str join "\n"
let selected = (echo $menu | wofi --dmenu --width 200 --height 300 --prompt "Power" | str trim)

if $selected != "" {
  let action = ($choices | where label == $selected | get action | first)
  let cmd = $action | split words
  run-external ...$cmd
}
