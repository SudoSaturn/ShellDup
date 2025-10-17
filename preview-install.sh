#!/bin/bash
#
# preview-install.sh
# Simulates the install-all.sh script to preview the appearance
#
# Usage:
#   bash preview-install.sh
#

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Progress bar function with smooth animation
show_progress() {
    local current=$1
    local total=$2
    local message=$3
    local target_percent=$((current * 100 / total))
    
    # Animate from previous to current with 0.2% increments
    local start_percent=$((prev_percent))
    for ((p=start_percent; p<=target_percent; p++)); do
        # Show 5 sub-steps per percent (0.2% increments)
        for sub in {0..4}; do
            local display_percent=$p
            if [ $p -eq $target_percent ] && [ $sub -gt 0 ]; then
                break
            fi
            
            local filled=$((display_percent * 30 / 100))
            # local empty=$((30 - filled))
            
            # Clear the line first
            printf "\r\033[K"
            printf "[%3d%%] " "$display_percent"
            printf "%${filled}s" | tr ' ' '█'
            printf "%${empty}s" | tr ' ' ' '
            
            sleep 0.001
        done
    done
    
    prev_percent=$target_percent
}

complete_step() {
    # Do nothing - just let the progress bar continue on the same line
    :
}

clear
echo ""
echo "               _          __          "
echo " ___ ___ _  __(_)______ _/ /____  ____"
echo "/ -_) _ \ |/ / / __/ _ \`/ __/ _ \/ __/"
echo "\__/_//_/___/_/\__/\_,_/\__/\___/_/   "
echo ""
echo ""
read -p "Press Enter to continue"
echo ""
clear
echo ""
echo ""
echo ""
echo "you need sudo access to run this"
echo ""
sudo -v
sleep 3
clear
echo ""
echo "BE PATIENT! this might take a while"
echo ""

TOTAL_STEPS=100
prev_percent=0

# Checking prerequisites (1-5)
for i in {1..5}; do
    show_progress $i $TOTAL_STEPS "Checking prerequisites..."
    sleep 0.05
done

# Cloning kitty (6-15)
for i in {6..15}; do
    show_progress $i $TOTAL_STEPS "Cloning kitty repository..."
    sleep 0.08
done

# Building kitty (16-40)
for i in {16..40}; do
    show_progress $i $TOTAL_STEPS "Building kitty..."
    sleep 0.12
done

# Installing documentation dependencies (41-50)
for i in {41..50}; do
    show_progress $i $TOTAL_STEPS "Installing documentation dependencies..."
    sleep 0.1
done

# Building documentation (51-60)
for i in {51..60}; do
    show_progress $i $TOTAL_STEPS "Building documentation..."
    sleep 0.15
done

# Building app bundle (61-75)
for i in {61..75}; do
    show_progress $i $TOTAL_STEPS "Building app bundle..."
    sleep 0.08
done

# Installing to /Applications (76-80)
for i in {76..80}; do
    show_progress $i $TOTAL_STEPS "Installing to /Applications..."
    sleep 0.1
done

# Cleanup kitty build (81-85)
for i in {81..85}; do
    show_progress $i $TOTAL_STEPS "Cleaning up build files..."
    sleep 0.05
done

# Cloning ShellDup (86-90)
for i in {86..90}; do
    show_progress $i $TOTAL_STEPS "Cloning ShellDup repository..."
    sleep 0.1
done

# Environment setup (91-100)
for i in {91..100}; do
    show_progress $i $TOTAL_STEPS "Setting up environment..."
    sleep 0.15
done

clear
echo ""
echo ""
echo "Installation complete!"
echo ""
read -p "Press Enter to apply changes..."
# source ~/.zshrc
echo ""
