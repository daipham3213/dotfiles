# ~/.config/fish/completions/openvpn3.fish

# Helper function to dynamically extract imported configuration names
function __fish_openvpn3_configs
    openvpn3 configs-list 2>/dev/null | string match -r -g '^\s*Name:\s*(.+)$'
end

# Helper function to dynamically extract active session D-Bus paths
function __fish_openvpn3_sessions
    openvpn3 sessions-list 2>/dev/null | string match -r -g '^(/net/openvpn/v3/sessions/[a-zA-Z0-9_]+)'
end

set -l cmds session-start session-manage sessions-list config-import config-manage config-remove configs-list log help version

# --- Base Commands ---
# We use -f here so file paths don't clutter the main subcommand list
complete -c openvpn3 -n "not __fish_seen_subcommand_from $cmds" -f -a session-start -d "Start a new VPN session"
complete -c openvpn3 -n "not __fish_seen_subcommand_from $cmds" -f -a session-manage -d "Manage an active VPN session"
complete -c openvpn3 -n "not __fish_seen_subcommand_from $cmds" -f -a sessions-list -d "List active VPN sessions"
complete -c openvpn3 -n "not __fish_seen_subcommand_from $cmds" -f -a config-import -d "Import a configuration file"
complete -c openvpn3 -n "not __fish_seen_subcommand_from $cmds" -f -a config-manage -d "Manage an imported configuration"
complete -c openvpn3 -n "not __fish_seen_subcommand_from $cmds" -f -a config-remove -d "Remove an imported configuration"
complete -c openvpn3 -n "not __fish_seen_subcommand_from $cmds" -f -a configs-list -d "List imported configurations"
complete -c openvpn3 -n "not __fish_seen_subcommand_from $cmds" -f -a log -d "Access log for a VPN session"
complete -c openvpn3 -n "not __fish_seen_subcommand_from $cmds" -f -a help -d "Show help"
complete -c openvpn3 -n "not __fish_seen_subcommand_from $cmds" -f -a version -d "Show version"

# --- session-start ---
# Use -r (requires argument) so it allows BOTH the dynamic configs (-a) AND your local files.
complete -c openvpn3 -n "__fish_seen_subcommand_from session-start" -l config -s c -r -a "(__fish_openvpn3_configs)" -d "Config name or file"
complete -c openvpn3 -n "__fish_seen_subcommand_from session-start" -l config-path -x -d "Configuration D-Bus path"
complete -c openvpn3 -n "__fish_seen_subcommand_from session-start" -l timeout -x -d "Connection timeout in seconds"

# --- session-manage ---
complete -c openvpn3 -n "__fish_seen_subcommand_from session-manage" -l session-path -s o -x -a "(__fish_openvpn3_sessions)" -d "Session D-Bus path"
complete -c openvpn3 -n "__fish_seen_subcommand_from session-manage" -l config -s c -x -a "(__fish_openvpn3_configs)" -d "Configuration name"
complete -c openvpn3 -n "__fish_seen_subcommand_from session-manage" -l disconnect -s D -d "Disconnect session"
complete -c openvpn3 -n "__fish_seen_subcommand_from session-manage" -l pause -s P -d "Pause session"
complete -c openvpn3 -n "__fish_seen_subcommand_from session-manage" -l resume -s r -d "Resume session"
complete -c openvpn3 -n "__fish_seen_subcommand_from session-manage" -l restart -s R -d "Restart session"

# --- config-import ---
# Use -r to allow local file paths naturally.
complete -c openvpn3 -n "__fish_seen_subcommand_from config-import" -l config -s c -r -d "Configuration file (.ovpn)"
complete -c openvpn3 -n "__fish_seen_subcommand_from config-import" -l name -s n -x -d "Name to store configuration as"
complete -c openvpn3 -n "__fish_seen_subcommand_from config-import" -l persistent -s p -d "Keep configuration across reboots"

# --- config-manage / config-remove ---
set -l conf_cmds config-manage config-remove
# Use -x (exclusive) because these commands ONLY take imported names, never local files.
complete -c openvpn3 -n "__fish_seen_subcommand_from $conf_cmds" -l config -s c -x -a "(__fish_openvpn3_configs)" -d "Configuration name"
complete -c openvpn3 -n "__fish_seen_subcommand_from $conf_cmds" -l config-path -x -d "Configuration D-Bus path"

# config-manage specific flags
complete -c openvpn3 -n "__fish_seen_subcommand_from config-manage" -l show -d "Show configuration details"
complete -c openvpn3 -n "__fish_seen_subcommand_from config-manage" -l rename -s r -x -d "Rename configuration"

# --- log ---
complete -c openvpn3 -n "__fish_seen_subcommand_from log" -l config -s c -x -a "(__fish_openvpn3_configs)" -d "Configuration name"
complete -c openvpn3 -n "__fish_seen_subcommand_from log" -l session-path -s o -x -a "(__fish_openvpn3_sessions)" -d "Session D-Bus path"
complete -c openvpn3 -n "__fish_seen_subcommand_from log" -l log-level -x -a "0 1 2 3 4 5 6" -d "Set log verbosity level"
