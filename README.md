# Arch Dotfiles

binnewbs/arch-hyprland

ViegPhunt/Dotfiles

여기서 코드 참고 많이 함 예쁘니까 구경ㄱㄱ

## 앱 구성

- 윈도우 매니저 : `Hyprland`
- 터미널 : `kitty`
- 쉘 : `zsh`
- 에디터 : `Helix`
- 상태 바 : `waybar`
- 알림 서버 : `mako` (아직 뭐 안 건드렸음)
- 런처 : `rofi`
- 로그아웃 메뉴 : `wlogout`
- 오디오 엔진 : `pipewire`
- 브라우저 : `firefox`
- 솔리테어 : `kpat`

## 장치 정보
일단 테스트는 VMware에서밖에 안 해봤음

실컴에선 어떤 부분이 잘못될지 잘 모르겠는데 일단 유력한건 Wi-fi랑 블루투스등 대충 장치 관련된쪽

# 마소는 들어라

마이크로소프트는 들어라 내가 아치로 넘어가는게 아치가 좋아서도 있지만 그것보다 느그 윈도우가 개씹좆창나서가 가장 큰 이유다
딱히 느그들 쓸만한 디버깅 정보를 주려는 의도는 없음 이미 백도어로 잘만 뜯어가고 계시잖아

## 마이크로소프트 계정
아주 설치부터 양아치 짓거리를 하심
로그인을 하라고? 로그인을 하라고? 좆이나 까잡수셔
뭔 정신나간 운영체제가 돈 주고 산걸 쓰는데 계정 로그인을 요구하냐?
계정이 없으면 만들라고? 아주 씨발 느그는 빵이 없으면 케이크 쳐먹어라를 실제로 하시네?
계정을 씨발 돈 주고 산 정품 운영체제 설치하는데 요구할거면 적어도 좀 사람새끼 쓸만한 수준으로는 만드는게 정상 아니냐?
근데 씨발 미성년자 계정 만들면 너네 지랄한다면서? 그게 씨발 20만 8천원 주고 산 운영체제 쓰는데 내가 당해야 할 일이 맞냐?
그러고나서도 씨발 오피스 쓰려면 로그인해라 원드라이브 쓰려면 로그인해라 아주 염병을 하세요 다 안 쓴다고 좆도 쓸모없다고 블로트웨어 치우라고 씹새끼들아
노골적으로 씨발 운영체제 설치에 계정을 요구해? 그래서 개인정보 데이터베이스 관리 아주 편해지셨어?

## 작업표시줄 숨김
난 작업표시줄 숨김 쓰거든? 마우스 포인터 아래로 슥 내리면 작업표시줄 슥 올라오는 그거? 당연히 씨발 작업표시줄은 왼쪽 정렬이지
근데 이거 가끔씩 마우스 포인터 아래로 내려도 작업표시줄 안 올라오는 문제가 터지더라 알트탭이나 윈도우 탭 써서 다른 창으로 넘어간 다음 쓰면 보통 해결됨
어떤 상황에 터지는지는 모르겠음 너무 자주 터져서 근데 확실한건 윈도우 사진 앱을 열면 무조건 터짐

## 램
램 이 씨발 할 말이 많다
너네는 씨발 진지하게 32 GB의 55%가 5260.9 MB로 보이냐?
내가 4502.4 MB를 쓰고있는데 15423 MB가 사용중이면 나머지 10920.6 MB는 썩을놈의 윈도우가 쳐먹고 있는게 맞지?
느그는 씨발 권한 보호 영역 희소 테이블 같은걸 2차원 배열로 처리하냐? 어떻게 운영체제가 램을 10기가를 쳐먹어?
내가 램 16기가 쓸 적에 리소스 모니터 보니까 씨발 별의 별 지랄을 해도 램 사용량이 6기가 아래로 내려가는 일을 본 적이 없어 6기가 찍은것도 몇 초만에 8기가로 회복됨
그래서 내가 씨발 아하 윈도우 이 순수체급 압도적인 블로트웨어 뭉텅이는 기본적으로 8기가를 먹는구나 생각했지
근데 32기가 써보니까 이제 15기가 아래로 안 내려가더라?
느그는 씨발 램의 절반을 운영체제가 항상 점유하고 있는게 운영체제로서 적절한 모델이라고 생각하냐?

내가 씨발 괜히 겁먹어서 JVM 인수를 8기가 최대로 걸어놓고 돌린거지?
내가 씨발 괜히 겁먹어서 안 그래도 부족한 16기가를 반토막내고 쓰던거지?
내가 씨발 괜히 겁먹어서 그런거지?

그리고 그게 아니더라도 씨발 느그는 검색이 안 쓸 때도 200 메가를 쳐먹는게 적절하다고 생각하는거지?
마이크로소프트 엣지 이 씨발 블로트웨어의 불후의 명작은 왜 쓰지도 않는데 켜져서는 램을 쳐먹냐 지우지도 못하는 씹새끼

램값 올라서 기분 더러운데 아주 안 그래도 더러운데에 똥칠을 똥칠을 찰지게 하셔

## 인공지능
야 이 씹새끼들아 안 쓴다고
코파일럿 키를 선택한 항목 없음으로 씨발 설정해놨으면 그냥 실수로 눌러도 싸닥치고 있지 왜 굳이 씨발 발정난 개새끼마냥 설정 창 띄우고 거기로 포커스 옮기면서 지랄 지랄을 하지?
그리고 씨발 설정 검색창 인공지능은 뭐 지 이름도 못 알아먹냐? 퍼지매칭으로도 충분한거에다가 훨씬 더 느린 인공지능을 씨발 쳐 구겨넣어놨으면 지 이름은 알아먹어야지 코파일럿 치면 검색결과가 없어? 니 애미도 없네요 씨발
그리고 그림판이고 메모장이고 검색창이고 캡처도구고 아주 여기저기에 창의적으로 똥을 싸질러놓으셨던데 씨발 안 쓴다니까? 안 쓰면 지울 수 있어야하는게 상식 아닌가?

## 2026-09-11
이 날 윈도우 포맷하기로 마음먹었음
수업에 필요해서 노트북 열었는데 갑자기 창 포커스가 안 먹더라? 눌러도 창 포커스가 안 잡히고 지랄임
작업표시줄 숨김도 안 올라오고 alt+f4도 안 먹어서 창 옮겨다닐 방법은 alt+tab밖에 없었음
작업표시줄 숨김 버그는 알트탭 한번 눌러서 창 옮기면 풀리던데 이번에는 풀리지도 않았음
마우스 입력도 뭔 먹다 말고 포커스도 안 잡히고 답이 없음 작업표시줄도 안 올라와서 전원버튼 못 누르고
그래서 Win+R 치고 cmd 켜서 shutdown /r 하고 재부팅 했거든
근데 씨발 업데이트를 한다네? 내 수업은?
내가 수업을 씨발 지금 당장 해야하는데 지랄하길래 재부팅 했더니 업데이트를 조지네?
아주 참 존나 유용하다 느그는 씨발 적당히를 모르냐?

## 총평
내가 지금까지 이 좆쓰레기를 꾸역꾸역 버티면서 쓴건 Powertoys 때문인줄 알아라 씨발
그것도 씨발 리눅스에선 pacman 몇 줄 딸깍딸깍 치고 30분정도 코딩하면 그냥 누릴 수 있는거지
느그는 이딴 장엄한 똥쓰레기를 20만 8천원에 팔아먹는게 아주 기분이 좋아서 가버릴 것 같구나?












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
pacman -S mesa gtk3 open-vm-tools (For VMware)
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
