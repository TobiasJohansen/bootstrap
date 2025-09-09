set -euo pipefail

# configure locale
sed -i 's/^#\s*\(en_US\.UTF-8 UTF-8\)/\1/' /etc/locale.gen
locale-gen

echo "==> Bootstrapping environment..."

pacman -Syu --noconfirm >/dev/null
pacman -S --noconfirm base-devel git man-db neovim openssh starship stow unzip xclip >/dev/null

echo "==> Setting up dotfiles..."

git clone https://github.com/TobiasJohansen/dotfiles ~/dotfiles >/dev/null
stow -d ~/dotfiles -t ~ .
source ~/.bashrc

echo "==> Bootstrap complete"

set +euo pipefail
