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
echo -e "\e[5;1;36m 🚀🚀 GAIANET NODE INSTALLER Tool-Kit BY GA CRYPTO 🚀🚀 \e[0m"
echo "==================================================="
echo -e "\e[1;97m✨ Your GPU, CPU & RAM Specs Matter for Optimal Performance! ✨\e[0m"
echo "==================================================="
echo -e "\e[1;33m🖥️ Desktop GPU Users = Earn Higher Points – Desktop GPUs are 10x More Powerful than Laptop GPUs! ⚡\e[0m"
echo -e "\e[1;33m💻 Laptop GPU Users = Earn More Points Than Non-GPU Users 🚀💸\e[0m"
echo -e "\e[1;33m🌐 VPS/Non-GPU Users = Earn Good Points Based on VPS Specifications ⚙️📊\e[0m"
echo "==================================================="
echo -e "\e[1;32m✅ Earn Gaia Points Continuously – Keep Your Node Active for Maximum Rewards! 💰\e[0m"
echo "==================================================="

echo -e "\n\e[1mPress a number to perform an action:\e[0m\n"
echo -e "1) \e[1;36m 🎮 Install Gaia-Node for NVIDIA Desktop GPU \e[0m"
echo -e "2) \e[1;36m 🖥️ Install Gaia-Node for VPS & Laptop GPU Users \e[0m"
echo -e "3) \e[1;94m 🤖 Detect System Configuration & Setup Chatbot \e[0m"
echo -e "4) \e[1;95m 🔍 Switch to Active Screens \e[0m"
echo -e "5) \e[1;31m 🚨 Terminate All Active GaiaNet Screens \e[0m"
echo "==================================================="

echo -e "6) \e[1;33m 🔄 Start or Restart GaiaNet Node \e[0m"
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
        if ! command -v gaianet &> /dev/null; then
            echo "❌ GaiaNet is not installed. Please install it first."
            exit 1
        fi

        gaianet_info=$(gaianet info 2>/dev/null)
        if [[ -z "$gaianet_info" ]]; then
            echo "❌ GaiaNet is not installed properly. Please check your installation."
            exit 1
        elif [[ "$gaianet_info" == *"Node ID"* || "$gaianet_info" == *"Device ID"* ]]; then
            echo "✅ GaiaNet is installed. Proceeding with chatbot setup."
        else
            echo "❌ GaiaNet is not installed properly. Please check your installation."
            exit 1
        fi

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
        echo "Checking for active screen sessions..."
        screen -list
        ;;

    5)
        echo "Terminating all 'gaiabot' screen sessions..."
        screen -ls | awk '/[0-9]+\./ && /gaiabot/ {print $1}' | xargs -r screen -X -S kill
        echo "✅ All 'gaiabot' screen sessions have been terminated."
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
