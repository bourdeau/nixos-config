#!/usr/bin/env nu

# get all sinks
let sinks = wpctl status | lines | where {|l| $l has "Audio/Sink"}

# find Scarlett safely
let scarlett_line = ($sinks | where {|l| $l has "Scarlett"} | last | default "MISSING")
let scarlett_id = if $scarlett_line != "MISSING" { ($scarlett_line | str trim | split words | first) } else { "" }

# find Corsair safely
let corsair_line = ($sinks | where {|l| $l has "CORSAIR"} | last | default "MISSING")
let corsair_id = if $corsair_line != "MISSING" { ($corsair_line | str trim | split words | first) } else { "" }

# get current default sink
let default_line = ($sinks | where {|l| $l has "*"} | last | default "MISSING")
let current_id = if $default_line != "MISSING" { ($default_line | str trim | split words | first) } else { "" }

# decide icon
if $current_id == $scarlett_id and $scarlett_id != "" {
    { text: "🎛️", tooltip: "Scarlett 2i2", class: "scarlett" } | to json -r | print
} else if $current_id == $corsair_id and $corsair_id != "" {
    { text: "🎧", tooltip: "Corsair Headset", class: "corsair" } | to json -r | print
} else if $current_id == "" {
    { text: "", tooltip: "No default audio", class: "error" } | to json -r | print
} else {
    { text: "", tooltip: "Other audio device", class: "other" } | to json -r | print
}
