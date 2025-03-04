#!/bin/bash

# Directory to store configuration files
FLAG_DIR="~/.vpnmanager"
CONFIG_ID_FILE="$FLAG_DIR/config_id"

# Function to display usage information
usage() {
    echo -e "Usage: vpnmanager [command]\n"
    echo "--set-config           - Updates the OpenVPN configuration to use"
    echo "--add-config {file}    - Adds a new config file to the configs list"
    echo "--list                 - Lists the available configurations"
    echo "--connect              - Connect to the set OpenVPN"
    echo "--disconnect           - Disconnects the active connection"
    exit 1
}

# Function to list available configurations
list_configs() {
    echo "Available configurations:"
    mapfile -t configs < <(find "$FLAG_DIR" -maxdepth 1 -type f -name "*.ovpn")
    
    if [[ ${#configs[@]} -eq 0 ]]; then
        echo "No configuration files found."
        return
    fi

    for i in "${!configs[@]}"; do
        echo "$i) $(basename "${configs[$i]}")"
    done
}

# Function to set the default configuration
set_config() {
    list_configs
    if [[ ${#configs[@]} -eq 0 ]]; then
        echo "No configurations available to set."
        return
    fi

    read -p "Enter the number of the configuration to set as default: " config_number

    if [[ $config_number =~ ^[0-9]+$ ]] && [[ $config_number -ge 0 ]] && [[ $config_number -lt ${#configs[@]} ]]; then
        echo "$config_number" > "$CONFIG_ID_FILE"
        echo "Configuration set to: $(basename "${configs[$config_number]}")"
    else
        echo "Invalid selection."
    fi
}

# Ensure the flag directory exists
mkdir -p "$FLAG_DIR"

# Check if at least one argument is provided
if [[ $# -lt 1 ]]; then
    usage
fi

# Handle commands
case $1 in
    --add-config)
        if [[ -f "$2" ]]; then
            mv "$2" "$FLAG_DIR"
            echo "Configuration file added: $(basename "$2")"
        else
            echo "Error: Incorrect path or file does not exist."
        fi
        ;;
    --list)
        list_configs
        ;;
    --set-config)
        set_config
        ;;
    --connect)
        if [[ -f "$CONFIG_ID_FILE" ]]; then
            config_id=$(cat "$CONFIG_ID_FILE")
            mapfile -t configs < <(find "$FLAG_DIR" -maxdepth 1 -type f -name "*.ovpn")
            
            if [[ $config_id =~ ^[0-9]+$ ]] && [[ $config_id -ge 0 ]] && [[ $config_id -lt ${#configs[@]} ]]; then
                echo "Connecting to: $(basename "${configs[$config_id]}")"
                sudo openvpn "${configs[$config_id]}" > /dev/null &
            else
                echo "Invalid configuration ID."
            fi
        else
            echo "No configuration set. Use --set-config to set a configuration."
        fi
        ;;
    --disconnect)
        echo "Disconnecting OpenVPN..."
        sudo killall openvpn
        ;;
    *)
        usage
        ;;
esac
