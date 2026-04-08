# ❄️ NixOS Configuration

Personal NixOS setup optimized for a minimal, keyboard-driven workflow.

---

## 🧠 Philosopy

This setup prioritizes:

- Simplicity
- Reproducibility
- keyboard-driven workflow
- Terminal centric style
- Low resource usage

---

## ⚠️ Disclaimer

This configuration is tailored for personal use and may not suit for everyone.

Use it as a reference, not a universal solution.

Inside is less GUI software and mostly just CLI tools

---

## 📦 What's Inside

- Window Manager : Sway
- Display Manager : Sddm
- Terminal : foot
- Shell : zsh (Heavy Configured in nix, check the [zsh.nix](./home/modules/zsh.nix) first)
- Browser : Firefox
- Email : Thunderbird
- Media : Spotify with spicetify, mpv and imv
- Dotfiles : rofi, waybar, sway, dunst, etc (check my [dotfiles](./dotfiles) folder)

---

## 🛠️ Customization

Feel free to:

- Replace CLI tools with GUI alternatives
- Replace Window Manager for example hyprland
- Add your preferred IDE (since i just using neovim)
- Enable SSH if you need

---

## 🚀 Usage

Appy Configuration:

```bash
sudo nixos-rebuild switch --flake .#your-hostname
```

---

## ⚖️ License

**MIT**
