function fish_prompt
    set savedstatus $status
    echo -n (set_color white)"╭─"(set_color normal)
    if [ $savedstatus != 0 ]
        set_color red
        echo -n $savedstatus" "
    end
    echo -n (set_color cyan)(date "+[%H:%M:%S]")(set_color normal) (pwd)(set_color white)
    __fish_git_prompt
    echo
    echo -n (set_color white)"╰─"(set_color green)'<")>< '(set_color normal)
end
