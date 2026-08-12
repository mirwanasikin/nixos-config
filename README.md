<h1 align=center>NixOS Personal Config ❄️</h1>

<div align=center>

![GitHub last commit](https://img.shields.io/github/last-commit/mirwanasikin/nixos-config?display_timestamp=author&style=for-the-badge&labelColor=black&color=%2394e2d5)
![GitHub repo size](https://img.shields.io/github/repo-size/mirwanasikin/nixos-config?style=for-the-badge&labelColor=black&color=%23cba6f7)

![GitHub License](https://img.shields.io/github/license/mirwanasikin/nixos-config?style=for-the-badge&labelColor=black&color=%23a6e3a1)

</div>

---

> [!CAUTION]
> This configuration is using NixOS nixpkgs master branch so there is the risk of not having binary cache inside. I still not sure is it work on your machine or not but I can make sure it will make your machine compile sometimes so if you don't want to compile it's better to use unstable or stable channel. Also in my Toshiba setup I'm using really old kernel which is 5.10 because I'm chasing the lightweight kernel. If you're running a new type of machine don't install the old kernel also I was disabling wireless hardening so pay attention to that config, if it breaks you don't blame me.

> [!IMPORTANT]
> This configuration is using agenix and heavy on my workflow so don't blindly copy my configuration, use it as a reference, not a universal solution. Inside is mostly are CLI tools.

---

## 🧠 Philosophy

Setup priorities:

- **Simplicity** - Less is more
- **Reproducibility** - Flake based _sound's cool but it's just the answer of my laziness to setup my new machine so I choose to keep it easier_
- **Keyboard Driven** - I'm typing with my 10 finger so it's suitable for me
- **Terminal Centric** - Easy typing with 10 finger and then terminal is all in one tool
- **Low Resource Usage** - I'm using 2010 Laptop BTW.

---

## 📦 Package I'm Using

Here's the package or software I mainly use in my workflow
| Category | Choice | Reason |
| -------- | ------ | ------ |
| `Kernel` | Kernel Linux LTS 5.10.y | It's an old laptop so LTS kernel its more suitable |
| `DE/WM` | Niri + Noctalia Shell v5 | Niri is compatible with my workflow and also Noctalia shell v5 is simple |
| `Display Manager` | sddm | I'm using Catppuccin theme and sddm is easy to customize |
| `Terminal` | Foot | I can't use kitty, alacritty can't render picture or emoji |
| `Browser` | Brave Origin| It's still experimental, maybe I'll make the flake soon or not |
| `Media` | Spotify | Well it's kinda easier and legal |
| `Text Editor` | Neovim | Well its lovable for 10 typing finger enjoyer |
| `Note Taking` | Obsidian | It's doing well since I'm used to markdown format |

> [!NOTE]
> Some packages are using community flakes so before you try to install it's better to check my [Flake](./flake.nix) first.

---

## ⚙️ Tools I use

Okay let's get a little bit serious, so of course I'm using some tools for development or DevOps and here's my tools i mainly use

- **Terraform/OpenTofu** - Right now I'm mostly use OpenTofu due to license and it's open source
- **Ansbile** - For configuration management in Cloud Service
- **AWS CLI** - AWS workflow like searching for AMI or looking which instance alive
- **Kubectl** - For kubernetes setup
- **Docker/Podman** - Container testing

---

If you ever interested with my setup you can copy a little bit and change the config like you want. Feel free to be references. peace.
