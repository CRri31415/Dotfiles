if pidof rofi > /dev/null; then
  pkill rofi
fi

rofi -modi emoji -show emoji
