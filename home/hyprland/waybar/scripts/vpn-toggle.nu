#!/usr/bin/env nu

try {
    let iface = "proton"
    let link_info = ip link show $iface | str trim
    let active = $link_info | str contains $iface

    if $active {
        alacritty -e sudo wg-quick down $iface
        notify-send "VPN" "VPN stopped successfully"
    } else {
        alacritty -e sudo wg-quick up $iface
        notify-send "VPN" "VPN started successfully"
    }

} catch {|e|
    notify-send "VPN Error" $"Failed to toggle VPN: ($e)"
}
