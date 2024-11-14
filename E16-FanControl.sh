#!/bin/bash

DEFAULTCONFIG=$(cat <<EOF
40:1
50:2
60:2
75:3
85:4
92:full-speed
EOF
)
AUTOFANVAL="1"

setAuto(){
    while true; do
        temperature=$(awk '{print $2}' /proc/acpi/ibm/thermal)
        echo "First temperature value: $temperature"
        while IFS=":" read -r key value; do
            if [ "$temperature" -ge "$key" ]; then
                AUTOFANVAL="$value"
               # echo "level $value" | sudo tee /proc/acpi/ibm/fan > /dev/null
                echo "set fan speed to $value"
            fi
        done < /etc/E16FanControlConfig.txt
        echo "level $AUTOFANVAL" | sudo tee /proc/acpi/ibm/fan > /dev/null

        sleep 20
    done
}

if [ "$1" == "-setSpeed" ]; then
    if [[ "$2" =~ ^[0-9]+$ ]]; then
        if [ "$2" -lt 1 ] || [ "$2" -gt 7 ]; then
            echo "Invalid Argument: Speed must be between 1-7."
        else
            echo "Speed set to $2"
            echo "level $2" | sudo tee /proc/acpi/ibm/fan > /dev/null
        fi
    elif [ "$2" == "max" ]; then
        echo "Setting speed to maximum (8)."
        echo "level full-speed" | sudo tee /proc/acpi/ibm/fan > /dev/null
    elif [ "$2" == "auto" ]; then
	    echo "Setting to auto mode"
         if [ -e /etc/E16FanControlConfig.txt ]; then
            echo "File found!"
        else
            mkdir -p ~/.config/E16FanControl
            echo "$DEFAULTCONFIG" > /etc/E16FanControlConfig.txt
            echo "Default configuration created at /etc/E16FanControlConfig.txt"
        fi
    else
        echo "Invalid Argument: Speed must be a number between 1-7, max or auto."
    fi
elif [ "$1" == "-setConfig" ]; then
    echo "s"
elif [ "$1" == "-autoSet" ]; then
    setAuto
else
    echo "Available Commamnds are
    -setSpeed : to set fan speed ranging from 1-7 or max
    -setConfig : generate a systemd config
    -auto: sets fan speed to auto 
    
    "
fi
