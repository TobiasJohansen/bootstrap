set -euo pipefail

echo "==> Configuring locale..."

sudo sed -i 's/^#\s*\(en_US\.UTF-8 UTF-8\)/\1/' /etc/locale.gen
sudo locale-gen >/dev/null

echo "==> Installing packages..."

sudo pacman -Syu --noconfirm >/dev/null
sudo pacman -S --noconfirm base-devel fd git keychain lazygit man-db neovim openssh pnpm ripgrep starship stow tmux tree-sitter-cli unzip xclip >/dev/null

USERNAME="tobias"
if ! id "$USERNAME" &>/dev/null; then
  echo "==> Adding user..."
  sudo useradd -m -G wheel -k /var/empty -s /bin/bash "$USERNAME"
  sudo sed -i 's/^# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/' /etc/sudoers
  if [ -v WSL_DISTRO_NAME ]; then
    echo "Exit WSL and run the following command to set '$USERNAME' as the default user"
    echo "wsl --manage archlinux --set-default-user $USERNAME"
  fi
fi

echo "==> Bootstrap complete"

set +euo pipefail
