function fish_prompt
    set_color red
    echo -n $status
    echo -n " "
    set_color cyan
    echo -n (date "+[%H:%M:%S]")
    echo -n " "
#    set_color white
#    cat /tmp/cpu_usage
#    echo -n " "
    set_color white
    echo -n (python -c 'print("%.1f" % (100.0*(1-'(cat /proc/meminfo | head -n 2 | tail -1 | awk '{print $2}')'.0/'(cat /proc/meminfo | head -1 | awk '{print $2}')')))')
    echo -n " "
    set_color yellow
    echo (pwd)
    set_color green
    echo -n '><> '
    set_color normal
end
