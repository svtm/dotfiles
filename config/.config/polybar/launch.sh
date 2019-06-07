#!/usr/bin/env sh

killall -q polybar


while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

#polybar top &
#ln -s /tmp/polybar_mqueue.$! /tmp/ipc-top


echo "Bars launched"

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload top &
  done
else
  polybar --reload top &
  #polybar --reload stats &
fi

polybar --reload stats &
rm -rf /tmp/ipc-stats
ln -s /tmp/polybar_mqueue.$! /tmp/ipc-stats

