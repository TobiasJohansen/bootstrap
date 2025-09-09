set -euo pipefail

echo "==> Configuring locale..."

sed -i 's/^#\s*\(en_US\.UTF-8 UTF-8\)/\1/' /etc/locale.gen
locale-gen >/dev/null

echo "==> Installing packages..."

pacman -Syu --noconfirm >/dev/null
pacman -S --noconfirm base-devel git man-db neovim openssh starship stow unzip xclip >/dev/null

curl -fsSL https://get.pnpm.io/install.sh | sh - >/dev/null

echo "==> Setting up dotfiles..."

git clone https://github.com/TobiasJohansen/dotfiles ~/dotfiles >/dev/null
stow -d ~/dotfiles -t ~ . >/dev/null
source ~/.bashrc

# pnpm env use --lts >/dev/null

echo "==> Bootstrap complete"

set +euo pipefail

cd ~/
