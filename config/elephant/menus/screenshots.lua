Name = "screenshots"
NamePretty = "Screenshots"
FixedOrder = true
HideFromProviderlist = true
Icon = ""
Parent = "capture"
function GetEntries()
    return {
        {
            Text = "Area → Clipboard",
            Icon = "",
            Actions = {
                -- hyprshot -m region (mode: region) -c (copy to clipboard)
                ["area_clipboard"] = "hyprshot -m region -c && notify-send 'Copied Area'",
            },
        },
        {
            Text = "Area → File",
            Icon = "",
            Actions = {
                -- hyprshot -m region (mode: region) -o (saves to default directory, usually ~/Pictures)
                ["area_file"] = "hyprshot -m region && notify-send 'Saved Screenshot'",
            },
        },
        {
            Text = "Window → Clipboard",
            Icon = "",
            Actions = {
                -- hyprshot -m window (mode: window) -c (copy to clipboard)
                ["window_clipboard"] = "hyprshot -m window -c && notify-send 'Copied Window'",
            },
        },
        {
            Text = "Window → File",
            Icon = "",
            Actions = {
                -- hyprshot -m window (mode: window)
                ["window_file"] = "hyprshot -m window && notify-send 'Saved Window'",
            },
        },
        {
            Text = "Fullscreen → Clipboard",
            Icon = "",
            Actions = {
                -- hyprshot -m output (mode: active output/monitor) -c (copy to clipboard)
                ["fullscreen_clipboard"] = "hyprshot -m output -c && notify-send 'Copied Fullscreen'",
            },
        },
        {
            Text = "Fullscreen → File",
            Icon = "",
            Actions = {
                -- hyprshot -m output (mode: active output/monitor)
                ["fullscreen_file"] = "hyprshot -m output && notify-send 'Saved Fullscreen'",
            },
        },
    }
end