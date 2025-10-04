#!/usr/bin/env nu

try {
    let active = (ip link show proton | complete | get exit_code) == 0

    let icon = if $active { " VPN" } else { " VPN" }
    let tooltip = if $active { "ProtonVPN active" } else { "ProtonVPN inactive" }
    let class = if $active { "on" } else { "off" }

    { text: $icon, tooltip: $tooltip, class: $class } | to json -r | print
} catch {|e|
    notify-send "VPN Error" $"($e)"
    { text: " VPN", tooltip: "VPN status: error", class: "error" } | to json -r | print
}
