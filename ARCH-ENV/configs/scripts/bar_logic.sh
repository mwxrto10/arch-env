#!/usr/bin/env bash

update_bar_visibility() {
    CURRENT_WS=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).name')
    WINDOW_COUNT=$(i3-msg -t get_tree | jq --arg ws "$CURRENT_WS" '
        recurse(.nodes[], .floating_nodes[]) 
        | select(.type=="workspace" and .name==$ws) 
        | .. 
        | select(.window_type?) 
        | .window' | wc -l)

    if [ "$WINDOW_COUNT" -gt "0" ]; then
        polybar-msg cmd show >/dev/null 2>&1
    else
        polybar-msg cmd hide >/dev/null 2>&1
    fi
}

update_bar_visibility
i3-msg -t subscribe -m '[ "window", "workspace" ]' | while read -r event; do
    update_bar_visibility
done