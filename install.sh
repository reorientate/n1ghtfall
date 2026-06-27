#!/bin/bash

# n1ghtfall Installation Script
# A really cool dark terminal theme for Zsh
# https://github.com/reorientate/n1ghtfall

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Print header
echo -e "${BLUE}"
echo "     ___       _   _   ___     _ _ "
echo " ___|_  |  ___| |_| |_|  _|___| | |"
echo "|   |_| |_| . |   |  _|  _| .'| | |"
echo "|_|_|_____|_. |_|_|_| |_| |__,|_|_|"
echo "     n1ght|___|fall.sh"
echo -e "${NC}"
echo -e "${GREEN}n1ghtfall Installation Script${NC}"
echo ""

# Check if Zsh is installed
if ! command -v zsh &> /dev/null; then
    echo -e "${RED}Error: Zsh is not installed. Please install Zsh first.${NC}"
    exit 1
fi

# Determine the target directory and backup directory
ZSHRC_PATH="${HOME}/.zshrc"
BACKUP_DIR="${HOME}/.n1ghtfall-backups"
BACKUP_FILE="${BACKUP_DIR}/.zshrc.backup"

# Create backup directory if it doesn't exist
if [ ! -d "$BACKUP_DIR" ]; then
    echo -e "${YELLOW}Creating backup directory...${NC}"
    mkdir -p "$BACKUP_DIR"
fi

# Backup existing .zshrc if it exists and hasn't been backed up already
if [ -f "$ZSHRC_PATH" ] && [ ! -f "$BACKUP_FILE" ]; then
    echo -e "${YELLOW}Backing up your existing .zshrc...${NC}"
    cp "$ZSHRC_PATH" "$BACKUP_FILE"
    echo -e "${GREEN}✓ Backup saved to $BACKUP_FILE${NC}"
elif [ ! -f "$ZSHRC_PATH" ]; then
    echo -e "${YELLOW}Creating new .zshrc file...${NC}"
    touch "$ZSHRC_PATH"
fi

# Clone or update the repository
INSTALL_DIR="${HOME}/.n1ghtfall"
if [ -d "$INSTALL_DIR" ]; then
    echo -e "${YELLOW}Updating existing n1ghtfall installation...${NC}"
    cd "$INSTALL_DIR"
    git pull origin main
else
    echo -e "${YELLOW}Cloning n1ghtfall repository...${NC}"
    git clone https://github.com/reorientate/n1ghtfall.git "$INSTALL_DIR"
fi

# Copy .zshrc configuration
echo -e "${YELLOW}Installing n1ghtfall theme...${NC}"
cp "$INSTALL_DIR/.zshrc" "$ZSHRC_PATH"

echo ""
echo -e "${GREEN}✓ Installation complete!${NC}"
echo ""
echo -e "${BLUE}To apply the theme, restart your terminal or run:${NC}"
echo -e "${YELLOW}  source ~/.zshrc${NC}"
echo ""
echo -e "${BLUE}You can also uninstall this theme by running:${NC}"
echo -e "${YELLOW}  nf-uninstall${NC}"
echo ""
echo -e "${BLUE}For more information, visit:${NC}"
echo -e "${YELLOW}  https://github.com/reorientate/n1ghtfall${NC}"
echo ""
