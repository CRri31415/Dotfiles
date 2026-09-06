if pidof rofi > /dev/null; then
  pkill rofi
fi

wallpaper_dir="$HOME/dotfiles/wallpapers"

selected=$(for p in "$wallpaper_dir"/*; do
  echo -en "$(basename "${p%.*}")\0icon\x1f$p\n"
done | rofi -dmenu)

[ -z "$selected" ] && exit 0

selected_path=$(find "$wallpaper_dir" -type f -name "$selected.*" | head -n 1)

if [ -n "$selected_path" ]; then
  $HOME/dotfiles/custom-script/wallpaper-change.sh "$selected_path"
fi
