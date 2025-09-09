set -euo pipefail

echo "==> Configuring locale..."

sed -i 's/^#\s*\(en_US\.UTF-8 UTF-8\)/\1/' /etc/locale.gen
locale-gen >/dev/null

echo "==> Installing packages..."

pacman -Syu --noconfirm >/dev/null
pacman -S --noconfirm base-devel fd git man-db neovim openssh ripgrep starship stow unzip xclip >/dev/null

if ! command -v pnpm &>/dev/null; then
  curl -fsSL https://get.pnpm.io/install.sh | sh - >/dev/null
  rm ~/.bashrc
fi

echo "==> Setting up dotfiles..."

if [ ! -d ~/dotfiles ]; then
  git clone https://github.com/TobiasJohansen/dotfiles ~/dotfiles >/dev/null 2>&1
fi
stow -d ~/dotfiles -t ~ . >/dev/null
source ~/.bashrc

cd ~/

pnpm env use --global lts >/dev/null

echo "==> Bootstrap complete"

set +euo pipefail
