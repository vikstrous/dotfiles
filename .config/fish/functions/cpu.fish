function cpu
  while true
    echo -n (top -b -d 1 -n 2 | grep Cpu | awk '{print $2}' | grep -o '[0-9.]\+' | tail -n 1) > /tmp/cpu_usage
  end
end
