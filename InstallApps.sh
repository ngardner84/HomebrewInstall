#!/bin/bash

# Function to install Xcode Command Line Tools
install_xcode_cli() {
  echo "Installing Xcode Command Line Tools..."
  xcode-select --install &>/dev/null

  # Wait until the Xcode CLI is installed
  until xcode-select -p &>/dev/null; do
    echo "Waiting for Xcode CLI installation to complete..."
    sleep 1
  done
  echo "Xcode CLI installed."
}

# Function to install Homebrew
install_homebrew() {
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

# Function to install specified cask
install_cask() {
  cask_name=$1
  echo "Installing $cask_name..."
  brew install --cask $cask_name
}

# Check if Xcode CLI is installed, if not, install it
if xcode-select -p &>/dev/null; then
  echo "Xcode CLI already installed."
else
  install_xcode_cli
fi

# Check if Homebrew is already installed
if command -v brew &>/dev/null; then
  echo "Homebrew already installed."
else
  install_homebrew
fi

# Install Adobe Creative Cloud
install_cask "adobe-creative-cloud"

# Install Microsoft Office
install_cask "microsoft-office"

# Install Zoom
install_cask "zoom"

# Install Google Chrome
install_cask "google-chrome"

# Install Firefox
install_cask "firefox"

# Exit status
if [ $? -eq 0 ]; then
  echo "All packages installed successfully."
else
  echo "Installation failed for one or more packages."
  exit 1
fi

# Note: Adobe and Microsoft installers may require you to sign in to complete the installation.
