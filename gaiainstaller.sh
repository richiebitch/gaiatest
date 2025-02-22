#!/bin/bash

# Check if screen is installed
if ! command -v screen &> /dev/null; then
    echo "❌ Screen is not installed. Installing screen..."
    sudo apt-get install -y screen
else
    echo "✅ Screen is already installed."
fi

while true; do
    clear
    echo "==================================================="
    echo -e "\e[5;1;36m 🚀🚀 GAIANET NODE INSTALLER BY GACRYPTO 🚀🚀 \e[0m"
    echo "==================================================="

    echo -e "\e[1;33m📌 NOTE: If you have an 🎮 NVIDIA GPU, keep your computer running for at least 20-24 hours for great results. 🚀🚀\e[0m"
    echo -e "\e[1;33m💰💰 Believe me - You'll farm higher Gaia Points! 💰💰\e[0m"
    echo "==================================================="
    echo -e "\e[1;32m✅ You'll still earn good points if running on VPS or non-GPU computers! 💰💰\e[0m"
    echo "==================================================="

    echo -e "\n\e[1mPress a number to perform an action:\e[0m\n"
    echo -e "1) \e[1;36m 🎮 Install Gaianet For NVIDIA GPU (RTX 20/30/40/50 Series Support) \e[0m"
    echo -e "2) \e[1;36m 🖥️ Install Gaianet For VPS & Without NVIDIA GPU Computers \e[0m"
    echo -e "3) \e[1;94m 🤖 Chat with Gaia Domain Automatically \e[0m"
    echo -e "4) \e[1;95m 🔍 Switch to Active Screens \e[0m"
    echo "==================================================="

    echo -e "5) \e[1;33m 🔄 Restart GaiaNet Node \e[0m"
    echo -e "6) \e[1;33m ⏹️ Stop GaiaNet Node \e[0m"
    echo "==================================================="

    echo -e "7) \e[1;36m 🔍 Press to check Your Gaia Node ID & Device ID \e[0m"
    echo "==================================================="

    echo -e "\e[1;31m⚠️  DANGER ZONE:\e[0m"
    echo -e "8) \e[1;31m 🗑️ Uninstall GaiaNet Node (Risky Operation) \e[0m"
    echo "==================================================="

    echo -e "\e[1;31m❌ TERMINATE ALL ACTIVE SCREENS:\e[0m"
    echo -e "9) \e[1;31m 🚨 Terminate All Active Screens \e[0m"
    echo "==================================================="

    read -p "Enter your choice: " choice

        case $choice in
        1)
            echo "Installing GaiaNet with NVIDIA GPU support..."
            rm -rf gaianodetest.sh
            curl -O https://raw.githubusercontent.com/abhiag/Gaiatest/main/gaianodetest.sh
            chmod +x gaianodetest.sh
            ./gaianodetest.sh
            ;;

        2)
            echo "Installing GaiaNet without GPU support..."
            rm -rf gaianodetest.sh
            curl -O https://raw.githubusercontent.com/abhiag/Gaiatest/main/gaianodetest.sh
            chmod +x gaianodetest.sh
            ./gaianodetest.sh
            ;;

        3)
            echo "Detecting system configuration..."

            # Check if GaiaNet is installed
            if ! command -v gaianet &> /dev/null; then
                echo "❌ GaiaNet is not installed. Please install it first."
                exit 1
            fi

            # Get GaiaNet info
            gaianet_info=$(gaianet info 2>/dev/null)

            # Validate GaiaNet installation
            if [[ -z "$gaianet_info" ]]; then
                echo "❌ GaiaNet is not installed properly or not responding. Please check your installation."
                exit 1
            elif [[ "$gaianet_info" == *"Node ID"* || "$gaianet_info" == *"Device ID"* ]]; then
                echo "✅ GaiaNet is installed. Proceeding with chatbot setup."
            else
                echo "❌ GaiaNet is not installed properly. Please check your installation."
                exit 1
            fi

            # Function to check if system is a VPS or Laptop
            check_if_vps_or_laptop() {
                vps_type=$(systemd-detect-virt)
                if echo "$vps_type" | grep -qiE "kvm|qemu|vmware|xen|lxc"; then
                    echo "✅ This is a VPS."
                    return 0  # VPS detected
                elif ls /sys/class/power_supply/ | grep -q "^BAT[0-9]"; then
                    echo "✅ This is a Laptop."
                    return 0  # Laptop detected
                else
                    echo "✅ This is a Desktop."
                    return 1  # Desktop detected
                fi
            }

            # Check if system is a VPS or Laptop
            if check_if_vps_or_laptop; then
                script_name="gaiabotga.sh"
                echo "🚀 Running VPS/Laptop version of Domain Chat..."
            else
                # Check for GPU on Desktop
                if command -v nvcc &> /dev/null || command -v nvidia-smi &> /dev/null; then
                    echo "✅ NVIDIA GPU detected on Desktop. Running GPU-optimized Domain Chat..."
                    script_name="gaiabotga1.sh"
                else
                    echo "⚠️ No GPU detected on Desktop. Running Non-GPU version..."
                    script_name="gaiabotga.sh"
                fi
            fi

            # Remove old script if it exists and download the new one
            if [[ -f ~/$script_name ]]; then
                rm -rf ~/$script_name
            fi

            # If no existing screen was selected, start a new one
            screen -dmS gaiabot bash -c '
            curl -O https://raw.githubusercontent.com/abhiag/Gaia_Node/main/'"$script_name"' && chmod +x '"$script_name"';
            if [ -f "'"$script_name"'" ]; then
                ./'"$script_name"'
                exec bash  # Keeps the session open
            else
                echo "❌ Error: Failed to download '"$script_name"'"
                sleep 10  # Pause before exit
            fi'

            sleep 2
            screen -r gaiabot
            ;;

        4)
            echo "Checking for active screen sessions..."
            mapfile -t active_screens < <(screen -list | grep -o '[0-9]*\.[^ ]*')

            if [[ ${#active_screens[@]} -gt 0 ]]; then
                echo "Active screens detected:"
                for i in "${!active_screens[@]}"; do
                    screen_id=$(echo "${active_screens[i]}" | cut -d. -f1)
                    screen_name=$(echo "${active_screens[i]}" | cut -d. -f2)
                    echo "$((i+1))) Screen ID: $screen_id - Name: $screen_name"
                done

                echo "Enter the number to switch to the corresponding screen (or type 'Exit' to return to the main menu):"
                read screen_choice

                if [[ "$screen_choice" == "Exit" ]]; then
                    echo "🔄 Returning to the main menu..."
                elif [[ "$screen_choice" =~ ^[0-9]+$ ]] && (( screen_choice > 0 && screen_choice <= ${#active_screens[@]} )); then
                    selected_screen=${active_screens[screen_choice-1]}
                    screen_id=$(echo "$selected_screen" | cut -d. -f1)
                    echo "Switching to screen ID $screen_id..."
                    screen -d -r "$screen_id"
                else
                    echo "❌ Invalid selection. Please try again."
                fi
            else
                echo "⚠️ No active screens found."
            fi
            ;;

        5)
            echo "Restarting GaiaNet Node..."
            gaianet stop
            gaianet init
            gaianet start
            gaianet info
            ;;

        6)
            echo "Stopping GaiaNet Node..."
            gaianet stop
            ;;

        7)
            echo "Checking Your Gaia Node ID & Device ID..."
            gaianet_info=$(gaianet info 2>/dev/null)
            if [[ -n "$gaianet_info" ]]; then
                echo "$gaianet_info"
            else
                echo "❌ GaiaNet is not installed or configured properly."
            fi
            ;;

        8)
            echo "⚠️ WARNING: This will completely remove GaiaNet Node from your system!"
            read -p "Are you sure you want to proceed? (yes/no) " confirm
            if [[ "$confirm" == "yes" ]]; then
                echo "🗑️ Uninstalling GaiaNet Node..."
                curl -sSfL 'https://github.com/GaiaNet-AI/gaianet-node/releases/latest/download/uninstall.sh' | bash
            else
                echo "Uninstallation aborted."
            fi
            ;;

        9)
            echo "Terminating all 'gaiabot' screen sessions..."
            screen -ls | awk '/[0-9]+\./ && /gaiabot/ {print $1}' | xargs -r screen -X -S kill
            echo "✅ All 'gaiabot' screen sessions have been terminated."
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
