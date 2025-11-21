# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a modular, cross-platform Home Manager configuration using **flake-parts** that manages:
- Development tools and programs (git, neovim, kitty, tmux, firefox) - **cross-platform**
- Hyprland (Wayland compositor) with complete desktop environment - **Linux only**
- System packages split by category (common, GUI apps, Linux-specific)
- Audio/video configuration (pipewire, OBS)

The configuration is designed to be **reusable** - individual modules can be imported into other flake-based configs via `inputs.cameron-home.homeModules.<module-name>`.

Flake inputs: nixpkgs-unstable, flake-parts, home-manager, custom neovim flake, nixGL, and NUR.

## Common Commands

### Apply Configuration Changes
```bash
home-manager switch --flake ~/.config/home-manager#cameron --impure
```
Note: The `--impure` flag is required for this configuration.

### Update Flake Inputs
```bash
nix flake update
```

### Check Flake Configuration
```bash
nix flake check
```

### Show Configuration Info
```bash
nix flake show
```

### Build Without Switching
```bash
home-manager build --flake ~/.config/home-manager#cameron --impure
```

## Architecture

### Flake-Parts Structure

The configuration uses **flake-parts** for modularity and cross-platform support. Key files:

- `flake.nix`: Uses flake-parts, exports homeModules and homeConfigurations
- `parts/`: Contains all reusable home-manager modules organized by category

```
parts/
├── home-modules/          # Program configurations (cross-platform)
│   ├── shell.nix         # Bash with vi-mode
│   ├── git.nix           # Git + SSH + gh CLI
│   ├── tmux.nix          # Tmux configuration
│   ├── firefox.nix       # Firefox with custom search engines
│   └── kitty.nix         # Kitty terminal
├── packages/             # Package groups
│   ├── common.nix        # CLI tools (cross-platform)
│   ├── gui-apps.nix      # GUI applications (cross-platform)
│   ├── gaming.nix        # Gaming packages (cross-platform)
│   └── linux-only.nix    # Linux-specific packages & configs
└── linux/                # Linux-only modules
    ├── mic.nix           # Microphone/pipewire config
    └── hyprland/         # Full Hyprland setup
        ├── default.nix
        ├── binds.nix
        ├── appearance.nix
        ├── monitors.nix
        ├── waybar.nix
        └── ...
```

### Exported Modules (flake.nix:36-53)

All modules under `parts/` are exported via `flake.homeModules` and can be imported by other flakes:

```nix
# In another flake:
inputs.cameron-home.homeModules.shell
inputs.cameron-home.homeModules.packages-common
inputs.cameron-home.homeModules.packages-gaming
inputs.cameron-home.homeModules.hyprland  # Linux only
inputs.cameron-home.homeModules.mic       # Linux only
```

### Platform Support

The flake supports multiple systems (`flake.nix:32`):
- `x86_64-linux` (primary, includes Hyprland)
- `aarch64-darwin` (macOS ARM)
- `x86_64-darwin` (macOS Intel)

For macOS configurations, simply omit Linux-specific modules (hyprland, packages-linux) when creating homeConfigurations.

### Key Design Patterns

1. **Flake-Parts Modularity**: Each part is self-contained and can be selectively imported. Platform-specific modules are clearly separated.

2. **Package Categorization**: Packages split into `common` (CLI tools), `gui-apps` (cross-platform GUI), and `linux-only` (Hyprland ecosystem, system tools).

3. **External Flake Integration**: Neovim managed by `github:CameronBadman/Nvim-flake`, included with extra dependencies.

4. **XDG Configuration**: Linux-only module includes pipewire and xdg-portal configs via `xdg.configFile`.

5. **Multi-Monitor Hyprland**: Dual-monitor setup with workspaces 1-5 on DP-2, 6-10 on DP-1 (`parts/linux/hyprland/default.nix:32-43`).

### Important Configuration Details

- **Neovim**: Managed by external flake at `github:CameronBadman/Nvim-flake`, included as package with extra dependencies
- **Shell**: Bash with vi-mode enabled, custom prompt with nix-shell indicator
- **Git**: Configured for user "Cameron Badman" with rebase on pull, auto-setup remote on push
- **Audio**: Pipewire configured with low-latency settings (1024 quantum, 48kHz)
- **Portal**: Uses hyprland portal for screencasting/screenshots, gtk portal as fallback
- **Allow Unfree**: Set in `modules/packages.nix:3` to enable proprietary packages

## Working with This Configuration

### Adding New Components

1. **Cross-platform programs**: Add to `parts/home-modules/`, export in `flake.nix` homeModules, import in homeConfiguration
2. **Packages**:
   - CLI tools → `parts/packages/common.nix`
   - GUI apps → `parts/packages/gui-apps.nix`
   - Gaming → `parts/packages/gaming.nix`
   - Linux-only → `parts/packages/linux-only.nix`
3. **Linux-specific** (Hyprland keybinds, waybar, pipewire, etc) → `parts/linux/`

### Creating a macOS Configuration

To use these modules on macOS, create a new homeConfiguration in `flake.nix`:

```nix
cameron-darwin = home-manager.lib.homeManagerConfiguration {
  pkgs = nixpkgs.legacyPackages.aarch64-darwin;  # or x86_64-darwin

  modules = [
    # Base config
    { home.username = "cameron"; ... }

    # Import cross-platform modules only
    self.homeModules.shell
    self.homeModules.git
    self.homeModules.tmux
    self.homeModules.firefox
    self.homeModules.kitty
    self.homeModules.packages-common
    self.homeModules.packages-gui
    self.homeModules.packages-gaming
    # Note: skip hyprland, packages-linux, and mic (Linux-only)
  ];
};
```

### Building and Updating

- Build: `home-manager build --flake ~/.config/home-manager#cameron --impure`
- Switch: `home-manager switch --flake ~/.config/home-manager#cameron --impure`
- Update flake inputs: `nix flake update`
- Update specific input: `nix flake lock --update-input <input-name>`

**Note**: The `--impure` flag is required for this configuration.
