#!/bin/bash

export LC_TIME=pt_BR.UTF-8

killall -9 waybar
killall -9 swaync
killall -9 swayosd

waybar &
swaync &
swayosd &
