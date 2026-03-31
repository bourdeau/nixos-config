#!/usr/bin/env nu

try {
    let iface = "proton"
    let link_info = ip link show $iface | str trim
    let active = $link_info | str contains $iface
    let service = $"wg-quick-($iface).service"

    if $active {
        alacritty -e sudo systemctl stop $service
        notify-send "VPN" "VPN stopped successfully"
    } else {
        alacritty -e sudo systemctl start $service
        notify-send "VPN" "VPN started successfully"
    }

} catch {|e|
    notify-send "VPN Error" $"Failed to toggle VPN: ($e)"
}
