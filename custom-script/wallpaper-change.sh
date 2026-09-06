wallpaper_path="$1"

if [ -z "$wallpaper_path" ]; then
  exit 1
fi

wallpaper_cache="/tmp/current-wallpaper"
wallpaper_path="${wallpaper_path/#\~/$HOME}"

if [ -f "$wallpaper_path" ]; then
  ln -sf "$wallpaper_path" "$wallpaper_cache"
  awww img "$wallpaper_cache"
  matugen image "$wallpaper_cache" --source-color-index 0
fi
