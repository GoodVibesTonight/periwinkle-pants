#!/bin/bash
set -e

# Log function
log() {
  echo -e "\033[1;32m==> $1\033[0m"
}

# 1. Install Homebrew
if ! command -v brew &>/dev/null; then
  log "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  log "Homebrew already installed."
fi

eval "$(/opt/homebrew/bin/brew shellenv || /usr/local/bin/brew shellenv)"

# 2. Update Homebrew
log "Updating Homebrew..."
brew update

# 3. Install essential tools
ESSENTIALS=(
  awscli
  git
  jq
  htop
  fzf
  bat
  wget
  zsh
  zsh-completions
  tree
)

log "Installing essential packages..."
brew install "${ESSENTIALS[@]}"

# 4. Set up Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  log "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  log "Oh My Zsh already installed."
fi

# 5. Install Powerlevel10k theme
POWERLEVEL9K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel9k"
if [ ! -d "$POWERLEVEL9K_DIR" ]; then
  log "Installing Powerlevel9k theme..."
  git clone https://github.com/bhilburn/powerlevel9k.git "$POWERLEVEL9K_DIR"
fi

# Set ZSH_THEME to powerlevel10k
sed -i '' 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc

# 6. Install zsh-autosuggestions and zsh-syntax-highlighting
log "Installing Zsh plugins..."
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

git clone https://github.com/zsh-users/zsh-autosuggestions \
  "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" || true

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting" || true

# Add plugins to .zshrc if not present
if ! grep -q "zsh-syntax-highlighting" ~/.zshrc; then
  echo "source ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
fi

if ! grep -q "zsh-autosuggestions" ~/.zshrc; then
  echo "source ${ZSH_CUSTOM}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
fi

# 7. Install fzf keybindings and completion
log "Setting up fzf keybindings..."
"$(brew --prefix)"/opt/fzf/install --all --no-bash --no-fish

# 8. Configure bat alias (batcat → bat on some platforms)
echo 'alias cat="bat"' >> ~/.zshrc

# 9. Final instructions
log "✅ Done! Now restart your terminal or run:"
echo "source ~/.zshrc"
