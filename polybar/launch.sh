#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar

# Launch bar1 and bar2
#for i in 1 2 3 4 5 6; do
#		MONITOR=$mon polybar -q cristina-bar -c $HOME/.config/polybar/config.ini &
#	done
#
MONITOR=$mon polybar -q cristina-bar -c $HOME/.config/polybar/config.ini &
