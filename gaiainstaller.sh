#!/bin/bash

# Check if screen is installed
if ! command -v screen &> /dev/null; then
    echo "❌ Screen is not installed. Installing screen..."
    sudo apt-get install -y screen
else
    echo "✅ Screen is already installed."
fi

# Function to list active screen sessions and allow user to select one
function select_screen_session() {
    while true; do
        echo "Checking for active screen sessions..."
        
        # Get the list of active screen sessions
        sessions=$(screen -list | grep -oP '\d+\.\S+' | awk '{print $1}')
        
        # Check if there are any active sessions
        if [ -z "$sessions" ]; then
            echo "No active screen sessions found."
            return  # Return to the main menu
        fi
        
        # Display the list of sessions with numbers
        echo "Active screen sessions:"
        i=1
        declare -A session_map
        for session in $sessions; do
            session_name=$(echo "$session" | cut -d'.' -f2)
            echo "$i) $session_name"
            session_map[$i]=$session
            i=$((i+1))
        done
        
        # Prompt the user to select a session
        echo -n "Select a session by number (1, 2, 3, ...) or press Enter to return to the main menu: "
        read choice
        
        # If the user presses Enter, return to the main menu
        if [ -z "$choice" ]; then
            return  # Return to the main menu
        fi
        
        # Validate the user's choice
        if [[ -z "${session_map[$choice]}" ]]; then
            echo "Invalid selection. Please try again."
            continue
        fi
        
        # Attach to the selected session
        selected_session=${session_map[$choice]}
        echo "Attaching to session: $selected_session"
        screen -r "$selected_session"
        break
    done
}

while true; do
    clear
    echo "==================================================="
    echo -e "\e[5;1;36m 🚀🚀 GAIANET NODE INSTALLER Tool-Kit BY GA CRYPTO 🚀🚀 \e[0m"
    echo "==================================================="
    echo -e "\e[1;97m✨ Your GPU, CPU & RAM Specs Matter for Optimal Performance! ✨\e[0m"
    echo "==================================================="

    # Stylish Performance & Requirement Section
    echo -e "\e[1;96m⏱  Keep Your Node Active Minimum 15 - 20 Hours Each Day! ⏳\e[0m"
    echo -e "\e[1;91m⚠️ Don’t Run Multiple Nodes if You Only Have 6-8GB RAM! ❌\e[0m"
    echo -e "\e[1;94m☁️ VPS Requirements: Minimum 8 Core+ CPU & 6-8GB RAM - Higher is Better! ⚡\e[0m"
    echo -e "\e[1;92m💻 PC/Desktop/Laptop: GPU RTX 20/30/40/50 Series Supported!🟢\e[0m"
    echo "==================================================="

    echo -e "\e[1;33m🖥️  Desktop GPU Users = Earn Higher Points – Desktop GPUs are 10x More Powerful than Laptop GPUs! ⚡🔥\e[0m"
    echo -e "\e[1;33m💻  Laptop GPU Users = Earn More Points Than Non-GPU Users 🚀💸\e[0m"
    echo -e "\e[1;33m🌐  VPS/Non-GPU Users = Earn Good Points Based on VPS Specifications ⚙️📊\e[0m"
    echo "==================================================="
    echo -e "\e[1;32m✅ Earn Gaia Points Continuously – Keep Your System Active for Maximum Rewards! 💰💰\e[0m"
    echo "==================================================="

    echo -e "\n\e[1mPress a number to perform an action:\e[0m\n"
    echo -e "1) \e[1;36m 🎮 Install Gaia-Node for Desktop NVIDIA GPU Users \e[0m"
    echo -e "2) \e[1;36m 🖥️ Install Gaia-Node for VPS & Laptop Nvidia GPU Users \e[0m"
    echo -e "3) \e[1;94m 🤖 Chat With Domain AUtomatically \e[0m"
    echo -e "4) \e[1;95m 🔍 Switch to Active Screens \e[0m"
    echo -e "5) \e[1;31m 🚨 Terminate All Active GaiaNet Screens \e[0m"
    echo "==================================================="

    echo -e "6) \e[1;33m 🔄 Restart GaiaNet Node \e[0m"
    echo -e "7) \e[1;33m ⏹️ Stop GaiaNet Node \e[0m"
    echo "==================================================="

    echo -e "8) \e[1;36m 🔍 Check Your Gaia Node ID & Device ID \e[0m"
    echo "==================================================="

    echo -e "\e[1;31m⚠️  DANGER ZONE:\e[0m"
    echo -e "9) \e[1;31m 🗑️ Uninstall GaiaNet Node (Risky Operation) \e[0m"
    echo "==================================================="

    echo -e "0) \e[1;31m ❌ Exit Installer \e[0m"
    echo "==================================================="

    read -p "Enter your choice: " choice

    echo -e "\e[1;97m 📢 Stay updated: \e[0m"
    echo -e "\e[1;97m Follow us on Telegram: https://t.me/GaCryptOfficial \e[0m"
    echo -e "\e[1;97m Follow us on X: https://x.com/GACryptoO \e[0m"

    case $choice in
        1)
            echo "Install Gaia-Node for Desktop NVIDIA GPU Users..."
            rm -rf gaianodetest.sh
            curl -O https://raw.githubusercontent.com/abhiag/Gaiatest/main/gaianodetest.sh
            chmod +x gaianodetest.sh
            ./gaianodetest.sh
            ;;

        2)
            echo "Install Gaia-Node for VPS & Laptop GPU Users..."
            rm -rf gaianodetest.sh
            curl -O https://raw.githubusercontent.com/abhiag/Gaiatest/main/gaianodetest.sh
            chmod +x gaianodetest.sh
            ./gaianodetest.sh
            ;;

                3)
            echo "Detecting system configuration..."

            # Check if GaiaNet is installed
            if ! command -v gaianet &> /dev/null; then
                echo -e "\e[1;31m❌ GaiaNet is not installed or not found. Please install it correctly.\e[0m"
                echo -e "\e[1;33m🔗 Must check your GaiaNet Node active status on: \e[1;34mhttps://www.gaianet.ai/setting/nodes\e[0m"
                echo -e "\e[1;33m🔍 If already installed, verify by running: \e[1;32m'gaianet info'\e[0m"
                read -p "Press Enter to return to the main menu..."
                continue
            fi

            # Check if GaiaNet is installed properly
            gaianet_info=$(gaianet info 2>/dev/null)
            if [[ -z "$gaianet_info" ]]; then
                echo -e "\e[1;31m❌ GaiaNet is installed but not configured properly. Please check your installation.\e[0m"
                echo -e "\e[1;33m🔗 Visit: \e[1;34mhttps://www.gaianet.ai/setting/nodes\e[0m to check the node status."
                echo -e "\e[1;33m🔍 Run: \e[1;32m'gaianet info'\e[0m to verify installation."
                read -p "Press Enter to return to the main menu..."
                continue
            fi

            # Proceed if GaiaNet is properly installed
            if [[ "$gaianet_info" == *"Node ID"* || "$gaianet_info" == *"Device ID"* ]]; then
                echo -e "\e[1;32m✅ GaiaNet is installed and detected. Proceeding with chatbot setup.\e[0m"
            else
                echo -e "\e[1;31m❌ GaiaNet is installed but not functioning correctly. Please verify installation.\e[0m"
                echo -e "\e[1;33m🔍 Run: \e[1;32m'gaianet info'\e[0m to confirm."
                echo -e "\e[1;33m🔗 Check: \e[1;34mhttps://www.gaianet.ai/setting/nodes\e[0m"
                read -p "Press Enter to return to the main menu..."
                continue
            fi

            # Function to check if the system is a VPS, laptop, or desktop
            check_if_vps_or_laptop() {
                vps_type=$(systemd-detect-virt)
                if echo "$vps_type" | grep -qiE "kvm|qemu|vmware|xen|lxc"; then
                    echo "✅ This is a VPS."
                    return 0
                elif ls /sys/class/power_supply/ | grep -q "^BAT[0-9]"; then
                    echo "✅ This is a Laptop."
                    return 0
                else
                    echo "✅ This is a Desktop."
                    return 1
                fi
            }

            # Determine the appropriate script based on system type
            if check_if_vps_or_laptop; then
                script_name="gaiachat.sh"
            else
                if command -v nvcc &> /dev/null || command -v nvidia-smi &> /dev/null; then
                    echo "✅ NVIDIA GPU detected on Desktop. Running GPU-optimized Domain Chat..."
                    script_name="gaiachat1.sh"
                else
                    echo "⚠️ No GPU detected on Desktop. Running Non-GPU version..."
                    script_name="gaiachat.sh"
                fi
            fi

            # Start the chatbot in a detached screen session
            screen -dmS gaiabot bash -c '
            curl -O https://raw.githubusercontent.com/abhiag/Gaiatest/main/'"$script_name"' && chmod +x '"$script_name"';
            if [ -f "'"$script_name"'" ]; then
                ./'"$script_name"'
                exec bash
            else
                echo "❌ Error: Failed to download '"$script_name"'"
                sleep 10
            fi'

            sleep 2
            screen -r gaiabot
            ;;

        4)
            select_screen_session
            ;;

        5)
            echo "🔴 Terminating and wiping all 'gaiabot' screen sessions..."
            screen -ls | awk '/[0-9]+\./ && /gaiabot/ {print $1}' | xargs -r screen -X -S kill
            find /var/run/screen -type s -name "*gaiabot*" -exec rm -rf {} + 2>/dev/null
            echo -e "\e[32m✅ All 'gaiabot' screen sessions have been terminated and wiped.\e[0m"
            ;;

        6)
            echo "Restarting GaiaNet Node..."
            gaianet stop
            gaianet init
            gaianet start
            gaianet info
            ;;

        7)
            echo "Stopping GaiaNet Node..."
            gaianet stop
            ;;

        8)
            echo "Checking Your Gaia Node ID & Device ID..."
            gaianet_info=$(gaianet info 2>/dev/null)
            if [[ -n "$gaianet_info" ]]; then
                echo "$gaianet_info"
            else
                echo "❌ GaiaNet is not installed or configured properly."
            fi
            ;;

        9)
            echo "⚠️ WARNING: This will completely remove GaiaNet Node from your system!"
            read -p "Are you sure you want to proceed? (yes/no) " confirm
            if [[ "$confirm" == "yes" ]]; then
                echo "🗑️ Uninstalling GaiaNet Node..."
                curl -sSfL 'https://github.com/GaiaNet-AI/gaianet-node/releases/latest/download/uninstall.sh' | bash
            else
                echo "Uninstallation aborted."
            fi
            ;;

        0)
            echo "Exiting..."
            exit 0
            ;;

        *)
            echo "Invalid choice. Please try again."
            ;;
    esac

    read -p "Press Enter to return to the main menu..."
done
