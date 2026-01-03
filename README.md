# IPA Translator Practice

This project uses Nix flakes for reproducible development environments. Follow these instructions to set up and run the project on your system.

This Practice work on:

&#x2611; Windows with WSL2.

&#x2611; MacOS Apple Silicon.

&#x2611; Linux.


The test were maded on Windows 11, Linux Arch, Linux NixOS and a Macbook Air M4.

---

## 1. Prerequisites

### NixOS / Linux / macOS
1. **Install Nix:**
	 - [Nix Installation Guide](https://nixos.org/download)
2. **Enable Flakes support:**
	 - Run:
		 ```sh
		 mkdir -p ~/.config/nix
		 echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
		 ```

### Windows (using WSL)
1. **Install WSL:**
	 - Open PowerShell as Administrator and run:
		 ```powershell
		 wsl --install -d Ubuntu-22.04
		 ```
	 - Restart your computer if prompted.
2. **Open Ubuntu (WSL) and follow the Linux steps above to install Nix and enable flakes.**

---

## 2. Clone the Repository

Open a terminal (Linux/macOS/WSL) and run:
```sh
git clone https://github.com/MiguelGavito/toIPA.git
cd toIPA
```

---

## 3. Enter the Development Environment

You can enter the Nix shell for the whole project or for each part individually:

- **Full project:**
	```sh
	nix develop
	```
- **Backend only:**
	```sh
	nix develop .#backend
	```
- **Frontend only:**
	```sh
	nix develop .#frontend
	```

On macOS can show an error that request to desactivate airdrop.

---

## 4. Run the Project

Open two terminals (or tabs):

### Frontend
```sh
cd frontend
yarn
yarn dev
```

### Backend
```sh
cd backend
python myapp.py
```

---

## 5. Notes

- Nix flakes ensure all dependencies and versions are consistent for every team member.
- If you encounter issues, check the Nix documentation or ask in the team chat.
- For Windows users, always work inside the Ubuntu WSL terminal.
- After finishing, you can clean all the download dependencies with the command:
	```sh
	nix-collect-garbage
	```
- to close temporal shells opened with nix develop or nix-shell use Ctrl + D.

---

## 6. Troubleshooting

- If `nix develop` fails, make sure flakes are enabled and you are in the correct directory.
- For WSL, ensure you are using Ubuntu 22.04 or newer.

---

Happy hacking!


