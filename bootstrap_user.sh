set -euo pipefail

echo "==> Configuring SSH..."

SSH_KEY_FILE="$HOME/.ssh/id_ed25519"
if [ ! -f "$SSH_KEY_FILE" ]; then
  echo ""
  read -p "Enter your email: " ssh_email

  git config --global user.email "$ssh_email"
  git config --global user.name "Tobias Johansen"

  ssh-keygen -q -t ed25519 -C "$ssh_email" -f "$SSH_KEY_FILE"

  echo ""
  echo "Add the following SSH key at https://github.com/settings/keys:"
  cat "${SSH_KEY_FILE}.pub"
  echo ""

  read -p "Press [Enter] to continue..."

  echo ""
  echo "Adding key to keychain..."
  eval $(keychain --eval --quiet id_ed25519)
  echo ""
fi

if ! ssh-keygen -F github.com >/dev/null 2>&1; then
  ssh-keyscan -t ed25519 github.com >>~/.ssh/known_hosts 2>/dev/null
fi

echo "==> Setting up dotfiles..."

if [ ! -d ~/dotfiles ]; then
  git clone git@github.com:TobiasJohansen/dotfiles.git ~/dotfiles >/dev/null 2>&1
fi
stow -d ~/dotfiles -t ~ . >/dev/null
source ~/.bashrc

cd ~/

pnpm env use --global lts >/dev/null

echo "==> Bootstrap complete"

set +euo pipefail
