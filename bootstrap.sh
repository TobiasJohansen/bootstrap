set -euo pipefail

# configure locale
sed -i 's/^#\s*\(en_US\.UTF-8 UTF-8\)/\1/' /etc/locale.gen
locale-gen

echo "==> Bootstrapping environment..."

pacman -Syu --noconfirm
pacman -S --noconfirm gcc git make man-db neovim openssh starship stow unzip xclip

echo "==> Setting up dotfiles..."

git clone https://github.com/TobiasJohansen/dotfiles ~/dotfiles
stow -d ~/dotfiles -t ~ .
source ~/.bashrc

echo "==> Bootstrap complete"
