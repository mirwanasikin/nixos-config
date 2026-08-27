<h1 align=center>NixOS Personal Config ❄️</h1>

<div align=center>

![GitHub last commit](https://img.shields.io/github/last-commit/mirwanasikin/nixos-config?display_timestamp=author&style=for-the-badge&labelColor=black&color=%2394e2d5)
![GitHub repo size](https://img.shields.io/github/repo-size/mirwanasikin/nixos-config?style=for-the-badge&labelColor=black&color=%23cba6f7)

![GitHub License](https://img.shields.io/github/license/mirwanasikin/nixos-config?style=for-the-badge&labelColor=black&color=%23a6e3a1)

</div>

---

> [!CAUTION]
> **Real talk:** This runs on nixpkgs master. No binary cache guarantee. Your machine _will_ compile things. A lot. If you'd rather not watch GCC spin for hours, stick to unstable or stable channels.
>
> Also — I'm daily-driving a 2010 Toshiba with kernel 6.18 (lightweight FTW) and wireless hardening disabled. If you're on modern hardware, don't copy that blindly. If it breaks, you keep both pieces.

> [!IMPORTANT]
> Heavy on agenix + my specific workflow. This isn't a drop-in solution — use it as a reference, not a template. Mostly CLI tools inside because that's how I roll.

---

## 🧠 The Vibe

**Simplicity** — Less config, less problems. I'd rather maintain 50 lines than 5000.

**Reproducibility** — Flakes sound fancy but honestly? They just save me from reconfiguring a new machine for the third time. Laziness-driven development.

**Keyboard-driven** — 10 fingers, zero mouse. If I can't navigate it with keys, I don't want it.

**Terminal-centric** — One tool to rule them all. TMUX sessions > GUI windows.

**Low resource usage** — Did I mention the 2010 laptop? Every MB counts.

---

## 📦 Daily Drivers

| Category          | Choice                   | Why Though                                                                          |
| ----------------- | ------------------------ | ----------------------------------------------------------------------------------- |
| `Kernel`          | Linux LTS 6.18.y         | Modern LTS, still runs fine on the 2010 tank.                                       |
| `WM/Shell`        | Niri + Noctalia Shell v5 | Niri's scrolling workflow clicks with my brain. Noctalia stays out of the way.      |
| `Display Manager` | SDDM                     | Catppuccin theme + easy theming = happy me.                                         |
| `Terminal`        | Foot                     | Kitty/Alacritty couldn't render images/emoji properly on my setup. Foot just works. |
| `Browser`         | Brave Origin             | Experimental fork. Might flake-ify it. Might not.                                   |
| `Media`           | Spotify                  | It's legal, it works, I'm not fighting it.                                          |
| `Editor`          | Neovim                   | 10-finger typing + modal editing = flow state.                                      |
| `Notes`           | Obsidian                 | Markdown-native, links work, graph view is oddly satisfying.                        |

> [!NOTE]
> Some packages pull from community flakes. Peek at [flake.nix](./flake.nix) before adopting anything.

---

## ⚙️ Dev/Infra Toolbox

- **OpenTofu** — Terraform's open-source fork. License drama dodged.
- **Ansible** — Config management for cloud stuff. Boring but reliable.
- **AWS CLI** — Hunting AMIs, checking instance health, the usual.
- **kubectl** — Kubernetes when I have to.
- **Docker/Podman** — Container testing. Podman for rootless, Docker when I'm lazy.

---

## 🤝 Wanna Borrow Bits?

Go for it. Cherry-pick what works, rewrite what doesn't. This config exists because I stood on shoulders — pay it forward.

Questions? Open an issue. Or don't. It's your machine.

---

_Built with ❄️ and excessive recompilation_

