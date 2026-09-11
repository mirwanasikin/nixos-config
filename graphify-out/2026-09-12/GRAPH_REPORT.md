# Graph Report - nixos-config  (2026-09-12)

## Corpus Check
- 6 files · ~1,448 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 47 nodes · 50 edges · 13 communities (4 shown, 9 thin omitted)
- Extraction: 88% EXTRACTED · 12% INFERRED · 0% AMBIGUOUS · INFERRED: 6 edges (avg confidence: 0.88)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `592b92b9`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- NixOS Personal Config
- main
- AGENTS.md
- opencode.json
- graphify.js
- Terminal-centric
- SDDM
- Docker
- Nix Flakes
- Keyboard-driven
- Linux LTS 6.18.y
- Niri
- update.sh script

## God Nodes (most connected - your core abstractions)
1. `NixOS Personal Config` - 25 edges
2. `main()` - 3 edges
3. `Terminal-centric` - 3 edges
4. `get_current_generation()` - 2 edges
5. `run()` - 2 edges
6. `SDDM` - 2 edges
7. `Docker` - 2 edges
8. `Podman` - 2 edges
9. `Nix Flakes` - 2 edges
10. `Reproducibility` - 2 edges

## Surprising Connections (you probably didn't know these)
- `Keyboard-driven` --rationale_for--> `NixOS Personal Config`  [EXTRACTED]
  README.md → README.md  _Bridges community 0 → community 23_
- `Low resource usage` --rationale_for--> `NixOS Personal Config`  [EXTRACTED]
  README.md → README.md  _Bridges community 0 → community 24_
- `NixOS Personal Config` --references--> `Docker`  [EXTRACTED]
  README.md → README.md  _Bridges community 0 → community 21_
- `NixOS Personal Config` --references--> `Nix Flakes`  [EXTRACTED]
  README.md → README.md  _Bridges community 0 → community 22_
- `NixOS Personal Config` --references--> `Foot Terminal`  [EXTRACTED]
  README.md → README.md  _Bridges community 0 → community 9_

## Import Cycles
- None detected.

## Hyperedges (group relationships)
- **Daily Drivers** — readme_linux_lts_6_18_y, readme_niri, readme_noctalia_shell_v5, readme_sddm, readme_foot, readme_firefox, readme_spotify, readme_neovim, readme_obsidian [EXTRACTED 1.00]
- **Design Principles** — readme_simplicity, readme_reproducibility, readme_keyboard_driven, readme_terminal_centric, readme_low_resource_usage [EXTRACTED 1.00]
- **Dev/Infra Toolbox** — readme_opentofu, readme_ansible, readme_aws_cli, readme_kubectl, readme_docker, readme_podman [EXTRACTED 1.00]

## Communities (13 total, 9 thin omitted)

### Community 0 - "NixOS Personal Config"
Cohesion: 0.17
Nodes (12): agenix, Ansible, AWS CLI, Firefox, flake.nix, kubectl, NixOS Personal Config, nixpkgs master (+4 more)

### Community 1 - "main"
Cohesion: 0.83
Nodes (3): get_current_generation(), main(), run()

### Community 2 - "AGENTS.md"
Cohesion: 0.25
Nodes (6): Common commands, Conventions, Gotchas, Layout, Matrix / CI, What this is

### Community 9 - "Terminal-centric"
Cohesion: 0.67
Nodes (3): Foot Terminal, Terminal-centric, TMUX

## Knowledge Gaps
- **20 isolated node(s):** `What this is`, `Layout`, `Conventions`, `Common commands`, `Gotchas` (+15 more)
  These have ≤1 connection - possible missing edges or undocumented components. (Counts symbols only; 25 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **9 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `NixOS Personal Config` connect `NixOS Personal Config` to `Terminal-centric`, `SDDM`, `Docker`, `Nix Flakes`, `Keyboard-driven`, `Linux LTS 6.18.y`, `Niri`?**
  _High betweenness centrality (0.306) - this node is a cross-community bridge._
- **Why does `SDDM` connect `SDDM` to `NixOS Personal Config`?**
  _High betweenness centrality (0.024) - this node is a cross-community bridge._
- **Are the 2 inferred relationships involving `Terminal-centric` (e.g. with `Foot Terminal` and `TMUX`) actually correct?**
  _`Terminal-centric` has 2 INFERRED edges - model-reasoned connections that need verification._
- **What connects `What this is`, `Layout`, `Conventions` to the rest of the system?**
  _20 weakly-connected nodes found - possible documentation gaps or missing edges._