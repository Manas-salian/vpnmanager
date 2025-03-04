# VPN Manager

## Overview

`vpnmanager.sh` is a bash script designed to manage OpenVPN configurations easily. It allows users to add, list, set, connect, and disconnect OpenVPN configurations through simple commands.
![[Screenshot from 2025-02-28 06-52-08.png]]
![[Screenshot from 2025-02-28 06-52-34.png]]
## Features

- **Add Configuration**: Add new OpenVPN configuration files.
- **List Configurations**: List all available OpenVPN configuration files.
- **Set Configuration**: Set a default OpenVPN configuration to use.
- **Connect**: Connect to the set OpenVPN configuration.
- **Disconnect**: Disconnect the active OpenVPN connection.

## Prerequisites

- **OpenVPN**: Ensure OpenVPN is installed on your system.
- **Bash**: The script is written in bash, so it requires a Unix-like environment.

## Installation

1. **Clone the Repository**:
    ```bash
    git clone https://github.com/yourusername/vpnmanager.git
    cd vpnmanager
    ```

2. **Make the Script Executable**:
    ```bash
    chmod +x vpnmanager.sh
    ```

## Usage

Run the script with the desired command:

```bash
./vpnmanager.sh [command]
```

### Commands

- `--add-config {file}`: Adds a new OpenVPN configuration file to the list.
    ```bash
    ./vpnmanager.sh --add-config /path/to/config.ovpn
    ```

- `--list`: Lists all available OpenVPN configuration files.
    ```bash
    ./vpnmanager.sh --list
    ```

- `--set-config`: Sets the default OpenVPN configuration to use.
    ```bash
    ./vpnmanager.sh --set-config
    ```

- `--connect`: Connects to the set OpenVPN configuration.
    ```bash
    ./vpnmanager.sh --connect
    ```

- `--disconnect`: Disconnects the active OpenVPN connection.
    ```bash
    ./vpnmanager.sh --disconnect
    ```

## Example Workflow

1. **Add a Configuration**:
    ```bash
    ./vpnmanager.sh --add-config /path/to/your/config.ovpn
    ```

2. **List Available Configurations**:
    ```bash
    ./vpnmanager.sh --list
    ```

3. **Set a Default Configuration**:
    ```bash
    ./vpnmanager.sh --set-config
    ```

4. **Connect to the VPN**:
    ```bash
    ./vpnmanager.sh --connect
    ```

5. **Disconnect from the VPN**:
    ```bash
    ./vpnmanager.sh --disconnect
    ```
