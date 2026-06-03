# ~/.config/fish/completions/openvpn3.fish
#
# Fish shell completions for the OpenVPN 3 Linux CLI (`openvpn3`).
#
# What this file provides:
# - Completes OpenVPN 3 subcommands such as `session-start`, `config-import`,
#   `config-manage`, `session-manage`, `configs-list`, `sessions-list`, and `log`.
# - Retrieves the available command list dynamically from
#   `openvpn3 shell-completion --list-commands`, so new OpenVPN 3 commands can
#   appear automatically when the installed CLI supports them.
# - Completes common command options and useful values, including imported
#   configuration names, active session D-Bus paths, session interfaces, log
#   levels, protocols, compression modes, and TLS versions.
#
# How to use:
# 1. Put this file at `~/.config/fish/completions/openvpn3.fish`.
# 2. Start a new fish shell, or reload completions with:
#      complete --erase openvpn3
#      source ~/.config/fish/completions/openvpn3.fish
# 3. Type `openvpn3 ` and press Tab to see available commands.
# 4. Type `openvpn3 <command> --` and press Tab to see options for that command.
#
# Requirements:
# - fish shell
# - OpenVPN 3 Linux CLI installed and available as `openvpn3`
# - OpenVPN 3 D-Bus services running for dynamic config/session completions
#
# Notes:
# - Dynamic config/session completions call `openvpn3 configs-list` and
#   `openvpn3 sessions-list`; if no configs or sessions exist, those completions
#   will simply be empty.
# - Options that accept local files intentionally allow file completion.
# - Options that only accept OpenVPN object names or D-Bus paths suppress file
#   completion to keep suggestions focused.

# Helper function to dynamically retrieve available openvpn3 commands.
function __fish_openvpn3_commands
    openvpn3 shell-completion --list-commands 2>/dev/null
end

# Helper function to dynamically extract imported configuration names.
function __fish_openvpn3_configs
    openvpn3 configs-list 2>/dev/null | string match -r -g '^\s*Name:\s*(.+)$'
end

# Helper function to dynamically extract active session D-Bus paths.
function __fish_openvpn3_sessions
    openvpn3 sessions-list 2>/dev/null | string match -r -g '^(/net/openvpn/v3/sessions/[a-zA-Z0-9_]+)'
end

# Helper function to dynamically extract active session interfaces.
function __fish_openvpn3_interfaces
    openvpn3 sessions-list 2>/dev/null | string match -r -g '^\s*Interface:\s*(.+)$'
end

set -l cmds (openvpn3 shell-completion --list-commands 2>/dev/null)

# --- Base Commands ---
# We use -f here so file paths don't clutter the main subcommand list.
complete -c openvpn3 -n "not __fish_seen_subcommand_from $cmds" -f -a "(__fish_openvpn3_commands)" -d "OpenVPN 3 command"
complete -c openvpn3 -n "not __fish_seen_subcommand_from $cmds" -f -a help -d "Show help"
complete -c openvpn3 -n "not __fish_seen_subcommand_from $cmds" -f -a shell-completion -d "Provide shell completion data"

# --- Common options ---
for cmd in $cmds shell-completion
    complete -c openvpn3 -n "__fish_seen_subcommand_from $cmd" -s h -l help -d "Show help"
end

# --- shell-completion ---
complete -c openvpn3 -n "__fish_seen_subcommand_from shell-completion" -l list-commands -d "List all available commands"
complete -c openvpn3 -n "__fish_seen_subcommand_from shell-completion" -l list-options -x -a "(__fish_openvpn3_commands)" -d "List options for command"
complete -c openvpn3 -n "__fish_seen_subcommand_from shell-completion" -l arg-helper -x -d "List value hints for option"

# --- config-import ---
# Use -r to allow local file paths naturally.
complete -c openvpn3 -n "__fish_seen_subcommand_from config-import" -l config -s c -r -d "Configuration file (.ovpn)"
complete -c openvpn3 -n "__fish_seen_subcommand_from config-import" -l name -s n -x -d "Name to store configuration as"
complete -c openvpn3 -n "__fish_seen_subcommand_from config-import" -l persistent -s p -d "Keep configuration across reboots"
complete -c openvpn3 -n "__fish_seen_subcommand_from config-import" -l tag -x -d "Add configuration tag"

# --- Config selection commands ---
set -l conf_cmds config-manage config-acl config-dump config-remove
complete -c openvpn3 -n "__fish_seen_subcommand_from $conf_cmds" -l path -s o -x -d "Configuration D-Bus path"
complete -c openvpn3 -n "__fish_seen_subcommand_from $conf_cmds" -l config-path -s o -x -d "Configuration D-Bus path"
complete -c openvpn3 -n "__fish_seen_subcommand_from $conf_cmds" -l config -s c -x -a "(__fish_openvpn3_configs)" -d "Configuration name"

# --- config-manage ---
complete -c openvpn3 -n "__fish_seen_subcommand_from config-manage" -l rename -s r -x -d "Rename configuration"
complete -c openvpn3 -n "__fish_seen_subcommand_from config-manage" -l tag -x -d "Add configuration tag"
complete -c openvpn3 -n "__fish_seen_subcommand_from config-manage" -l remove-tag -x -d "Remove configuration tag"
complete -c openvpn3 -n "__fish_seen_subcommand_from config-manage" -l show -s s -d "Show configuration details"
complete -c openvpn3 -n "__fish_seen_subcommand_from config-manage" -l exists -d "Check if configuration exists"
complete -c openvpn3 -n "__fish_seen_subcommand_from config-manage" -l quiet -d "Suppress output"
complete -c openvpn3 -n "__fish_seen_subcommand_from config-manage" -l dco -d "Enable data channel offload"
complete -c openvpn3 -n "__fish_seen_subcommand_from config-manage" -l server-override -x -d "Override server host"
complete -c openvpn3 -n "__fish_seen_subcommand_from config-manage" -l port-override -x -d "Override server port"
complete -c openvpn3 -n "__fish_seen_subcommand_from config-manage" -l proto-override -x -a "udp tcp" -d "Override server protocol"
complete -c openvpn3 -n "__fish_seen_subcommand_from config-manage" -l ipv6 -d "Enable IPv6"
complete -c openvpn3 -n "__fish_seen_subcommand_from config-manage" -l persist-tun -d "Preserve TUN device"
complete -c openvpn3 -n "__fish_seen_subcommand_from config-manage" -l log-level -x -a "0 1 2 3 4 5 6" -d "Set log verbosity level"
complete -c openvpn3 -n "__fish_seen_subcommand_from config-manage" -l dns-fallback-google -d "Use Google DNS as fallback"
complete -c openvpn3 -n "__fish_seen_subcommand_from config-manage" -l dns-setup-disabled -d "Disable DNS setup"
complete -c openvpn3 -n "__fish_seen_subcommand_from config-manage" -l dns-scope -x -d "Set DNS scope"
complete -c openvpn3 -n "__fish_seen_subcommand_from config-manage" -l dns-sync-lookup -d "Synchronize DNS lookups"
complete -c openvpn3 -n "__fish_seen_subcommand_from config-manage" -l auth-fail-retry -d "Retry authentication failures"
complete -c openvpn3 -n "__fish_seen_subcommand_from config-manage" -l allow-compression -x -a "no asym yes" -d "Allow compression mode"
complete -c openvpn3 -n "__fish_seen_subcommand_from config-manage" -l enable-legacy-algorithms -d "Enable legacy algorithms"
complete -c openvpn3 -n "__fish_seen_subcommand_from config-manage" -l tls-version-min -x -a "1.0 1.1 1.2 1.3" -d "Set minimum TLS version"
complete -c openvpn3 -n "__fish_seen_subcommand_from config-manage" -l tls-cert-profile -x -d "Set TLS certificate profile"
complete -c openvpn3 -n "__fish_seen_subcommand_from config-manage" -l proxy-host -x -d "Set proxy host"
complete -c openvpn3 -n "__fish_seen_subcommand_from config-manage" -l proxy-port -x -d "Set proxy port"
complete -c openvpn3 -n "__fish_seen_subcommand_from config-manage" -l proxy-username -x -d "Set proxy username"
complete -c openvpn3 -n "__fish_seen_subcommand_from config-manage" -l proxy-password -x -d "Set proxy password"
complete -c openvpn3 -n "__fish_seen_subcommand_from config-manage" -l proxy-auth-cleartext -d "Allow cleartext proxy auth"
complete -c openvpn3 -n "__fish_seen_subcommand_from config-manage" -l enterprise-profile -d "Set enterprise profile mode"
complete -c openvpn3 -n "__fish_seen_subcommand_from config-manage" -l automatic-restart -d "Enable automatic restart"
complete -c openvpn3 -n "__fish_seen_subcommand_from config-manage" -l unset-override -x -d "Unset configuration override"

# --- config-acl ---
complete -c openvpn3 -n "__fish_seen_subcommand_from config-acl" -l show -s s -d "Show access control list"
complete -c openvpn3 -n "__fish_seen_subcommand_from config-acl" -l grant -s G -x -d "Grant access to user"
complete -c openvpn3 -n "__fish_seen_subcommand_from config-acl" -l revoke -s R -x -d "Revoke access from user"
complete -c openvpn3 -n "__fish_seen_subcommand_from config-acl" -l public-access -d "Allow public access"
complete -c openvpn3 -n "__fish_seen_subcommand_from config-acl" -l transfer-owner-session -s T -x -d "Transfer owner session"
complete -c openvpn3 -n "__fish_seen_subcommand_from config-acl" -l lock-down -d "Lock down configuration"
complete -c openvpn3 -n "__fish_seen_subcommand_from config-acl" -l seal -s S -d "Seal configuration"

# --- config-dump ---
complete -c openvpn3 -n "__fish_seen_subcommand_from config-dump" -l json -s j -d "Dump as JSON"

# --- config-remove ---
complete -c openvpn3 -n "__fish_seen_subcommand_from config-remove" -l force -d "Remove without confirmation"

# --- configs-list ---
complete -c openvpn3 -n "__fish_seen_subcommand_from configs-list" -l count -d "Show only count"
complete -c openvpn3 -n "__fish_seen_subcommand_from configs-list" -l json -d "Output JSON"
complete -c openvpn3 -n "__fish_seen_subcommand_from configs-list" -l verbose -s v -d "Show verbose output"
complete -c openvpn3 -n "__fish_seen_subcommand_from configs-list" -l filter-config -x -a "(__fish_openvpn3_configs)" -d "Filter by configuration"
complete -c openvpn3 -n "__fish_seen_subcommand_from configs-list" -l filter-tag -x -d "Filter by tag"
complete -c openvpn3 -n "__fish_seen_subcommand_from configs-list" -l filter-owner -x -d "Filter by owner"

# --- session-start ---
# Use -r so it allows both dynamic configs and local files.
complete -c openvpn3 -n "__fish_seen_subcommand_from session-start" -l config -s c -r -a "(__fish_openvpn3_configs)" -d "Config name or file"
complete -c openvpn3 -n "__fish_seen_subcommand_from session-start" -l config-path -s p -x -d "Configuration D-Bus path"
complete -c openvpn3 -n "__fish_seen_subcommand_from session-start" -l persist-tun -d "Preserve TUN device"
complete -c openvpn3 -n "__fish_seen_subcommand_from session-start" -l timeout -x -d "Connection timeout in seconds"
complete -c openvpn3 -n "__fish_seen_subcommand_from session-start" -l background -d "Start in background"
complete -c openvpn3 -n "__fish_seen_subcommand_from session-start" -l dco -d "Enable data channel offload"

# --- Session selection commands ---
set -l sess_cmds session-manage session-acl session-stats log
complete -c openvpn3 -n "__fish_seen_subcommand_from $sess_cmds" -l session-path -s o -x -a "(__fish_openvpn3_sessions)" -d "Session D-Bus path"
complete -c openvpn3 -n "__fish_seen_subcommand_from $sess_cmds" -l path -s o -x -a "(__fish_openvpn3_sessions)" -d "Session D-Bus path"
complete -c openvpn3 -n "__fish_seen_subcommand_from $sess_cmds" -l config -s c -x -a "(__fish_openvpn3_configs)" -d "Configuration name"
complete -c openvpn3 -n "__fish_seen_subcommand_from $sess_cmds" -l interface -s I -x -a "(__fish_openvpn3_interfaces)" -d "Network interface"

# --- session-manage ---
complete -c openvpn3 -n "__fish_seen_subcommand_from session-manage" -l log-level -x -a "0 1 2 3 4 5 6" -d "Set log verbosity level"
complete -c openvpn3 -n "__fish_seen_subcommand_from session-manage" -l timeout -x -d "Operation timeout in seconds"
complete -c openvpn3 -n "__fish_seen_subcommand_from session-manage" -l pause -s P -d "Pause session"
complete -c openvpn3 -n "__fish_seen_subcommand_from session-manage" -l resume -s R -d "Resume session"
complete -c openvpn3 -n "__fish_seen_subcommand_from session-manage" -l restart -d "Restart session"
complete -c openvpn3 -n "__fish_seen_subcommand_from session-manage" -l disconnect -s D -d "Disconnect session"
complete -c openvpn3 -n "__fish_seen_subcommand_from session-manage" -l cleanup -d "Clean up stale session"

# --- session-auth ---
complete -c openvpn3 -n "__fish_seen_subcommand_from session-auth" -l auth-req -x -d "Authentication request ID"

# --- session-acl ---
complete -c openvpn3 -n "__fish_seen_subcommand_from session-acl" -l show -s s -d "Show access control list"
complete -c openvpn3 -n "__fish_seen_subcommand_from session-acl" -l grant -s G -x -d "Grant access to user"
complete -c openvpn3 -n "__fish_seen_subcommand_from session-acl" -l revoke -s R -x -d "Revoke access from user"
complete -c openvpn3 -n "__fish_seen_subcommand_from session-acl" -l public-access -d "Allow public access"
complete -c openvpn3 -n "__fish_seen_subcommand_from session-acl" -l allow-log-access -d "Allow log access"

# --- session-stats ---
complete -c openvpn3 -n "__fish_seen_subcommand_from session-stats" -l json -s j -d "Output JSON"

# --- log ---
complete -c openvpn3 -n "__fish_seen_subcommand_from log" -l log-level -x -a "0 1 2 3 4 5 6" -d "Set log verbosity level"
