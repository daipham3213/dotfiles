function fish_greeting
    fastfetch
end

function fish_prompt
    echo -n (prompt_pwd)
    echo -n " > "
end

abbr -a s sudo
abbr -a update sudo pacman -Syu
abbr -a pi sudo pacman -S
abbr -a pr sudo pacman -Rns
abbr -a k kubectl

if status is-interactive
    cat ~/.cache/wallust/sequences
end

if status is-login
    set -Ux GTK_IM_MODULE fcitx
    set -Ux QT_IM_MODULE fcitx
    set -Ux XMODIFIERS "@im=fcitx"
    set -Ux SDL_IM_MODULE fcitx
    set -Ux GLFW_IM_MODULE ibus
end

set -ga PATH $HOME/.local/bin

starship init fish | source
