if pidof rofi > /dev/null; then
  pkill rofi
fi

wallpaper_dir="$HOME/dotfiles/wallpapers"

selected=$(for p in "$wallpaper_dir"/*; do
  echo -en "$(basename "${p%.*}")\0icon\x1f$p\n"
done | rofi -dmenu)

selected_path=$(find "$wallpaper_dir" -type f -name "$selected.*" | head -n 1)

awww img "$selected_path"

matugen image "$selected_path" --source-color-index 0
