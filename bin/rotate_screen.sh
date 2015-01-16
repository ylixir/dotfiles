#!/bin/bash
touchpadString="SynPS/2 Synaptics TouchPad"
touchpadID=$(xinput list | grep "$touchpadString" | awk -F " " '{print $6}' | awk -F "=" '{print $2}')

#first get the state of the touchpad and the screen orientation.
touchpad_enabled=$(xinput list-props $touchpadID | grep "Device Enabled" | awk -F ":" '{print $2}')
current_orientation=$(xrandr|grep " connected" |awk '{print $4}')
# Check for arguments on the command line
if [ $# -eq 1 ]; then # Any arguments?
  if [ $(echo $1 | tr [:upper:] [:lower:]) = 'reset' ]; then
    touchpad_enabled='0'
    current_orientation='left'
  fi
fi

if [ $touchpad_enabled -eq 1 ]; then     # Enabled now?
  xinput --set-prop $touchpadID "Device Enabled" 0
                    # Yes, so disable it
else                    # Must be disabled, so...
  case $current_orientation in
      "(normal" )
          xrandr -o inverted
          xinput set-prop --type=int --format=8 "Atmel Atmel maXTouch Digitizer" "Evdev Axes Swap" "0"
          xinput set-prop "Atmel Atmel maXTouch Digitizer" "Evdev Axis Inversion" 1 1
          ;;
      "inverted" )
          xrandr -o right

          xinput set-prop --type=int --format=8 "Atmel Atmel maXTouch Digitizer" "Evdev Axes Swap" "1"
          xinput set-prop "Atmel Atmel maXTouch Digitizer" "Evdev Axis Inversion" 0 1
          ;;
      "right" )
          xrandr -o left
          xinput set-prop --type=int --format=8 "Atmel Atmel maXTouch Digitizer" "Evdev Axes Swap" "1"
          xinput set-prop "Atmel Atmel maXTouch Digitizer" "Evdev Axis Inversion" 1 0
          ;;
      "left" )
          xrandr -o normal
          xinput set-prop --type=int --format=8 "Atmel Atmel maXTouch Digitizer" "Evdev Axes Swap" "0"
          xinput set-prop "Atmel Atmel maXTouch Digitizer" "Evdev Axis Inversion" 0 0
          xinput --set-prop $touchpadID "Device Enabled" 1
          ;;
      * )
          xinput --set-prop $touchpadID "Device Enabled" 1
          echo "c est autre chose"
          current_orientation
          ;;
  esac
fi


