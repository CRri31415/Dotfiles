# Arch Dotfiles

binnewbs/arch-hyprland

ViegPhunt/Dotfiles

여기서 코드 참고 많이 함 예쁘니까 구경ㄱㄱ

## 앱 구성

- 윈도우 매니저 : `Hyprland`
- 터미널 : `kitty`
- 쉘 : `zsh`
- 에디터 : `Helix`
- 상태 바 : `quickshell`
- 알림 서버 : `mako` (아직 뭐 안 건드렸음)
- 런처 : `rofi`
- 로그아웃 메뉴 : `wlogout`
- 오디오 엔진 : `pipewire`
- 브라우저 : `firefox`
- 솔리테어 : `kpat`

# 아치 설치 명령어 목록 내가 보려고 만듬

loadkeys us
iwctl
    
fdisk -l

fdisk /dev/nvme0n1

lsblk

mkswap /dev/nvme0n1p2

swapon /dev/nvme0n1p2

mkfs.fat -F 32 /dev/nvme0n1p1

mkfs.ext4 /dev/nvme0n1p3

mount /dev/nvme0n1p3 /mnt

mount --mkdir /dev/nvme0n1p1 /mnt/boot

pacstrap /mnt base linux linux-firmware sudo grub efibootmgr networkmanager helix git

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot -S /mnt

ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime

hwclock --systohc

helix /etc/locale.gen

    171xd:wq
    
locale-gen

echo "LANG=en_US.UTF-8" >> /etc/locale.conf

echo "KEYMAP=us" >> /etc/vconsole.conf

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB

grub-mkconfig -o /boot/grub/grub.cfg

passwd

useradd -m user

passwd user

pacman -S mesa gtk3 vulkan-radeon lib32-mesa lib32-vulkan-radeon (For AMD)

helix ~/.bashrc

    export EDITOR="helix"
    
    export VISUAL="helix"
    
source ~/.bashrc

visudo

    124jdd:wq
usermod -aG wheel user

mkinitcpio -P

exit

umount -R /mnt

reboot

sudo systemctl enable --now NetworkManager

iwctl

sudo pacman -S git

mkdir ~/dotfiles

git clone https://github.com/CRri31415/Dotfiles ~/dotfiles

git config --global user.name CRri31415

git config --global user.email crri31415@gmail.com

git config --global init.defaultBranch main

ssh-keygen -t ed25519 -C crri31415@gmail.com

cat ~/.ssh/id_ed25519.pub

얻은 키는 깃허브에서 설정 -> SSH 키 들어가서 추가하기

cd ~/dotfiles

git init

git add .

git commit -m "Init"

git remote add origin git@github.com:CRri31415/Dotfiles

git pull --rebase

git push -u origin main

sudo groupadd --force uinput

sudo usermod -aG input,uinput user

echo 'KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"' | sudo tee /etc/udev/rules.d/99-input.rules

sudo udevadm control --reload-rules && sudo udevadm trigger

stow kanata

stow systemd

fc-cache -fv

systemctl --user enable --now kanata

systemctl --user enable --now pipewire pipewire-pulse wireplumber

sudo systemctl enable --now bluetooth

