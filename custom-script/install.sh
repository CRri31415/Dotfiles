#!/usr/bin/env bash

pacman_pkgs=(
  hyprland hypridle hyprlock hyprcursor mako swww hyprpolkiagent

  rofi-wayland rofi-emoji waybar wl-clipboard cliphist

  kitty dolphin

  stow openssh tree base-devel

  pipewire pipewire-pulse pipewire-alsa pipewire-jack wireplumber pavucontrol

  bluez bluez-utils
)

sudo pacman -S "${pacman_pkgs[@]}"

cd ~/
mkdir Downloads
cd Downloads

git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si

read

cd ~/Downloads
rm -rf yay-bin

yay_pkgs=(
  kanata-bin fastfetch firefox bottom 

  ttf-juliamono-nerd-font noto-fonts noto-fonts-cjk noto-fonts-emoji

  wtype wlogout grim slurp zsh

  fcitx5-im fcitx5-configtool fcitx5-hangul

  kpat
)

yay -S "${yay_pkgs[@]}"

pause


