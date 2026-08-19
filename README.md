# Dotfiles

Personal Arch Linux dotfiles for a Hyprland-based Wayland desktop.

This repository contains configuration files and installer scripts for setting up a desktop environment with Hyprland, fish, Kitty, Waybar, Dunst, Rofi, Neovim, Fcitx5 Lotus, matugen, and other daily-use tools.

## What is included

- **Hyprland desktop configuration**
  - Hyprland
  - Hyprlock
  - Hyprpaper
  - Hyprpolkitagent
  - UWSM environment files

- **Shell and terminal setup**
  - fish shell
  - Starship prompt
  - Kitty terminal
  - fish completions, including OpenVPN 3 completions

- **Desktop utilities**
  - Waybar
  - Dunst
  - Rofi
  - Nautilus
  - Firefox
  - Fastfetch
  - btop

- **Clipboard and media tools**
  - wl-clipboard
  - cliphist
  - playerctl

- **Networking and VPN tools**
  - WireGuard tools
  - OpenVPN 3
  - cloudflared

- **Input method**
  - Fcitx5
  - Fcitx5 Qt support
  - Fcitx5 Lotus

- **Theming**
  - matugen (Material You color generation from the current wallpaper)
  - wallpaper/theme templates
  - GTK theme templates
  - Nerd fonts

## Requirements

This setup is designed for **Arch Linux** or an Arch-based distribution.

Required before installing:

- `bash`
- `sudo`
- `git`
- `pacman`
- internet connection

The installer can install `paru` automatically if it is missing.

## Installation

### Option 1: Bootstrap from a fresh system

Run the bootstrap script from this repository source:

```sh
curl https://dots.mux0.dev/setup.sh
```

The bootstrap script will:

1. Ensure `git` is installed.
2. Clone this repository into:

   ```text
   ~/.dotfiles
   ```

3. Pull the latest changes if `~/.dotfiles` already exists.
4. Run the installer from `installers/install`.

### Option 2: Manual clone

```sh
git clone https://github.com/daipham3213/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
bash installers/install
```

> The main installer expects the repository to be located at `~/.dotfiles`.

## What the installer does

The installer performs these steps:

1. Installs `paru` if it is not already installed.
2. Installs packages listed in `installers/pkgs.txt`.
3. Copies files from `config/` into `~/.config/`.
4. Enables the Ly display manager service.
5. Sets up Neovim/LazyVim configuration.
6. Enables the Fcitx5 Lotus input method service.
7. Prompts for reboot when finished.

## Package list

Packages are managed in:

```text
installers/pkgs.txt
```

The file is grouped with `#` comments by category. Empty lines and comments are ignored by the installer.

To add a package, edit `installers/pkgs.txt`:

```text
# Example category
package-name
```

Then rerun:

```sh
bash ~/.dotfiles/installers/install
```

## Configuration usage

Most configuration files are stored under `config/` and are copied to:

```text
~/.config/
```

For example:

```text
config/fish/      -> ~/.config/fish/
config/hypr/      -> ~/.config/hypr/
config/kitty/     -> ~/.config/kitty/
config/waybar/    -> ~/.config/waybar/
config/matugen/   -> ~/.config/matugen/
```

After changing files in this repository, rerun the config setup script to copy them again:

```sh
bash ~/.dotfiles/installers/setup-config
```

## Notes

- This repository is tailored for the author's personal Hyprland desktop setup.
- Review scripts before running them on your own machine.
- Some packages come from the AUR and are installed through `paru`.
- Some services, such as Ly and Fcitx5 Lotus, are enabled with `systemctl`.
- A reboot is recommended after installation.