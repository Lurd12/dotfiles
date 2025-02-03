#!/bin/sh
set -e
xset s off dpms 0 10 0
/home/lur/.config/lock.sh
xset s off -dpms
