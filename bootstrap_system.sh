set -euo pipefail

echo "==> Configuring locale..."

sed -i 's/^#\s*\(en_US\.UTF-8 UTF-8\)/\1/' /etc/locale.gen
locale-gen >/dev/null

echo "==> Installing packages..."

pacman -Syu --noconfirm >/dev/null
pacman -S --noconfirm base-devel fd git keychain lazygit man-db neovim openssh pnpm ripgrep starship stow tree-sitter-cli unzip xclip >/dev/null

USERNAME="tobias"
if ! id "$USERNAME" &>/dev/null; then
  echo "==> Adding user..."
  useradd -m -G wheel -k /var/empty -s /bin/bash "$USERNAME"
  sed -i 's/^# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/' /etc/sudoers
  if [ -v WSL_DISTRO_NAME ]; then
    echo "Exit WSL and run the following command to set '$USERNAME' as the default user"
    echo "wsl --manage archlinux --set-default-user $USERNAME"
  fi
fi

echo "==> Bootstrap complete"

set +euo pipefail
