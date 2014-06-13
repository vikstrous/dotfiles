function nudge
  eval $argv; notify-send -h string:bgcolor:\#ffffff -h string:fgcolor:\#ff4444 "Done:\n$argv"
end
