wallpaper_dir="$HOME/dotfiles/wallpapers"

rand_wallpaper=$(find "$wallpaper_dir" -maxdepth 1 -type f | shuf -n 1)

rand_wallpaper="${rand_wallpaper/#\~/$HOME}"

if [ -f "$rand_wallpaper" ]; then
  $HOME/dotfiles/custom-script/wallpaper-change.sh "$rand_wallpaper"
else
  echo "$rand_wallpaper"
  exit 1
fi
