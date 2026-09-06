if pidof rofi > /dev/null; then
  pkill rofi
fi

wallpaper_dir="$HOME/dotfiles/wallpapers"
wallpaper_cache="$HOME/dotfiles/current-wallpaper"

selected=$(for p in "$wallpaper_dir"/*; do
  echo -en "$(basename "${p%.*}")\0icon\x1f$p\n"
done | rofi -dmenu)

[ -z "$selected" ] && exit 0

selected_path=$(find "$wallpaper_dir" -type f -name "$selected.*" | head -n 1)

if [ -n "$selected_path" ]; then
  ln -sf "$selected_path" "$wallpaper_cache"
  
  awww img "$wallpaper_cache"
  matugen image "$wallpaper_cache" --source-color-index 0
fi
