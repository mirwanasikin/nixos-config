<h1 align="center">❄️ Irwan's NixOS Config</h1>

<div align="center">

> *"I'm too lazy to remember what I installed or configured, so I declared everything."*

![GitHub last commit](https://img.shields.io/github/last-commit/mirwanasikin/nixos-config?display_timestamp=author&style=for-the-badge&labelColor=black&color=%2394e2d5)
![GitHub repo size](https://img.shields.io/github/repo-size/mirwanasikin/nixos-config?style=for-the-badge&labelColor=black&color=%23cba6f7)
![GitHub License](https://img.shields.io/github/license/mirwanasikin/nixos-config?style=for-the-badge&labelColor=black&color=%23a6e3a1)

</div>

---

> [!CAUTION]
> **Living on the Edge (Literally):** This configuration tracks **`nixpkgs/master`**.
>
> - **Zero binary cache guarantees:** You *will* hear the CPU fan scream as it compiles packages from source.
> - **Things break:** master moves fast and breaks things faster.
> - If you want peace of mind or value your battery life, stick to `nixos-unstable` or the official stable channels.

> [!IMPORTANT]
> **Secrets Management:** Secrets are strictly encrypted using **[agenix](https://github.com/ryantm/agenix)** (`secrets/*.age`).
>
> - Decryption requires matching private SSH keys configured for this specific host.
> - This repository is my personal blueprint and reference, **not** a turnkey, plug-and-play distro installer.

---

## 🧠 The Philosophy

### 1. Declarative Because I'm Lazy

I don't use NixOS to look smart. I use NixOS because I have terrible memory—or more accurately, I am simply too lazy to remember:

- What package did I install four months ago to convert an audio file?
- Which random config file in `/etc` did I tweak at 2 AM?
- What environment variables made that one tool work?

With NixOS, if an app or tweak isn't written down in this repository, **it does not exist**. One rebuild reproduces my entire digital brain.

### 2. CLI-First & The Touch Typist Tax

I am a touch typist. Reaching for the mouse feels like a penalty—it interrupts thought and breaks the rhythm of typing.

Terminal applications and TUIs are fast, predictable, keyboard-driven, and consume virtually zero system resources. For that reason, 95% of my computing happens inside Foot, Tmux, and Neovim.

What about GUI apps? A select few survive (like a web browser, because browsing modern web in w3m is an act of pure masochism). For the handful of GUI applications that made the cut: **feel free to snoop around the config files (`home/modules/`) to see what survived.**

---

## 💻 The Machine

**Toshiba Satellite A665** — a 2010-era laptop that refuses to die.

| Component | Spec |
| :---------- | :----- |
| **CPU** | Intel Core i3 M 380 @ 2.53GHz (2C/4T) |
| **RAM** | 8GB DDR3 |
| **Storage** | SSD SATA III 512GB, LUKS-encrypted ext4 root + swap |
| **Age** | 16 years old and counting |
| **Status** | Still compiling from source like a champ |

This vintage hardware is exactly *why* I default to CLI tools—every GUI byte counts when your laptop predates the smartphone era.

---

## ⌨️ The Daily Drivers

| Layer | Tool | Why |
| :------ | :----- | :---- |
| **Compositor** | Niri (scrollable tiling) + Noctalia | Wayland-native, no X baggage |
| **Terminal** | Foot | Blazing fast Wayland terminal |
| **Multiplexer** | Tmux | Persistent sessions, split panes |
| **Shell** | Fish + Starship | Sensible defaults, beautiful prompt |
| **Editor** | LazyVim (Neovim) | Preconfigured IDE via flake input |
| **File Manager** | Yazi | TUI, vim motions, image previews |
| **System Monitor** | htop, btop | Because `top` is boring |
| **Fuzzy Find** | fzf, fd, ripgrep | Fast, keyboard-driven search |
| **Music** | Spicetify (Spotify) + Spotatui | GUI when I feel fancy, TUI otherwise |
| **Browser** | Firefox + w3m | Modern web + emergency terminal browsing |
| **Notes** | Obsidian | The one GUI I actually need |
| **DevOps** | k9s, kubectl, awscli2, terraform, ansible | Kubernetes/cloud wrangling |

**GUI Apps?** Only a handful survive: Firefox, Obsidian, ProtonVPN, MPV, Imv, Zathura. Check `home/modules/packages.nix` for the full list.

---

## 📂 Layout

```
├── flake.nix               # Inputs + outputs (nixosConfiguration "toshiba")
├── flake.lock              # Lockfile — commit it, never hand-edit
├── hosts/toshiba/          # Host-specific NixOS modules
│   ├── configuration.nix   # Main system entrypoint
│   ├── hardware-configuration.nix  # Auto-generated, don't touch
│   └── modules/            # agenix, boot, desktop, kernel, network, etc.
├── home/                   # Home Manager module tree
│   ├── home.nix            # User environment entrypoint
│   └── modules/            # Fish, Foot, Git, Niri, Tmux, LazyVim, etc.
├── dotfiles/               # Out-of-store symlinked configs
├── secrets/                # Agenix-encrypted *.age files — SENSITIVE
├── wallpaper/              # Pretty pictures (decorative only)
├── update.py / update.sh   # Interactive rebuild/update workflows
└── graphify-out/           # Generated knowledge graph (auto-generated)
```

---

## 🚀 Quick Usage

```bash
# Dry-run to check what will change
nixos-rebuild dry-build --flake ~/nixos-config#toshiba

# Apply the configuration
sudo nixos-rebuild switch --flake ~/nixos-config#toshiba

# Update flake inputs (warning: compiles everything on master)
nix flake update --flake ~/nixos-config

# Interactive update workflow (commits, dry-build, prompt, switch, diff)
./update.py
```

---

## 🤝 License & Borrowing

Licensed under MIT. Cherry-pick whatever's useful as a reference—modules, configs, or philosophy.

Just remember: if you copy the kernel config or hardware-specific tweaks, you might wake up to a bricked system and regret.

*Built with ❄️ and the sound of laptop fans at max RPM.*
