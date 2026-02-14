#!/usr/bin/env nu

# get all sinks
let sinks = wpctl status | lines | where {|l| $l has "Audio/Sink"}

# find Scarlett safely
let scarlett_line = ($sinks | where {|l| $l has "Scarlett"} | last | default "MISSING")
let scarlett_id = if $scarlett_line != "MISSING" { ($scarlett_line | trim | split words | first) } else { "" }

# find Corsair safely
let corsair_line = ($sinks | where {|l| $l has "CORSAIR"} | last | default "MISSING")
let corsair_id = if $corsair_line != "MISSING" { ($corsair_line | trim | split words | first) } else { "" }

# get current default sink
let default_line = ($sinks | where {|l| $l has "*"} | last | default "MISSING")
let current_id = if $default_line != "MISSING" { ($default_line | trim | split words | first) } else { "" }

# toggle between Scarlett and Corsair
if $scarlett_id != "" && $current_id == $scarlett_id && $corsair_id != "" {
    wpctl set-default $corsair_id
    notify-send "Audio output" "Corsair Headset"
} else if $corsair_id != "" && $current_id == $corsair_id && $scarlett_id != "" {
    wpctl set-default $scarlett_id
    notify-send "Audio output" "Scarlett 2i2"
} else if $scarlett_id != "" {
    wpctl set-default $scarlett_id
    notify-send "Audio output" "Scarlett 2i2"
} else if $corsair_id != "" {
    wpctl set-default $corsair_id
    notify-send "Audio output" "Corsair Headset"
} else {
    notify-send "Audio toggle" "No known audio devices found"
}
