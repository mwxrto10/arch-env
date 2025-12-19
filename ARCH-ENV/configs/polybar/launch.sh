#!/usr/bin/env bash

killall -q polybar
killall -q bar_logic.sh

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

polybar main &
~/.config/scripts/bar_logic.sh &