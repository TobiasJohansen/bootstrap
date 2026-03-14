set -euo pipefail

echo "==> Configuring locale..."

sed -i 's/^#\s*\(en_US\.UTF-8 UTF-8\)/\1/' /etc/locale.gen
locale-gen >/dev/null

echo "==> Installing packages..."

pacman -Syu --noconfirm >/dev/null
pacman -S --noconfirm base-devel fd git keychain lazygit man-db neovim openssh ripgrep starship stow tree-sitter-cli unzip xclip >/dev/null

echo "==> Bootstrap complete"

set +euo pipefail
