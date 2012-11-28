output=$(i3-msg -t get_workspaces | python ~/.i3/focused_output.py)

i3-msg workspace $1
i3-msg move workspace to output $output
sleep 0.1
i3-msg workspace $1
