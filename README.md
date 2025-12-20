# IPA Transalator Practice

This practices uses Nix flakes for reproducible develpment envirnments.

## Requirements

- Install Nix (https://nixos.org/download)
- Enable Flakes support (usually: Enable Flakes support (usually: `mkdir -p ~/.config/nix && echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf`)

## Enter the Dev Environment

For all tools at once: <nix develop>

Or just the backend: <nix develop .#backend>

or just the frontend: <nix develop .#frontend>

Once inside the shell:

**Frontend:**
yarn dev

**Backend:**
python myapp.py


