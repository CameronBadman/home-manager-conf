{
  description = "Cameron's Home Manager Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvim-flake = {
      url = "github:CameronBadman/Nvim-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";
  };

  outputs = inputs@{ self, flake-parts, nixpkgs, home-manager, nvim-flake, nixgl, nur, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-darwin" "x86_64-darwin" ];

      flake = {
        # Export home-manager modules for reuse
        homeModules = {
          # Cross-platform modules
          shell = ./parts/home-modules/shell.nix;
          git = ./parts/home-modules/git.nix;
          tmux = ./parts/home-modules/tmux.nix;
          firefox = ./parts/home-modules/firefox.nix;
          kitty = ./parts/home-modules/kitty.nix;
          mic = ./parts/home-modules/mic.nix;

          # Package groups
          packages-common = ./parts/packages/common.nix;
          packages-gui = ./parts/packages/gui-apps.nix;
          packages-linux = ./parts/packages/linux-only.nix;

          # Linux-specific
          hyprland = ./parts/linux/hyprland;
        };

        # Home configurations
        homeConfigurations = {
          # Linux configuration
          cameron = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.x86_64-linux;

            modules = [
              { _module.args = { inherit inputs; }; }

              # Neovim from external flake
              ({ pkgs, ... }: {
                home.packages = [
                  nvim-flake.packages.x86_64-linux.default
                ] ++ (nvim-flake.extraPackages pkgs);
              })

              # NUR overlay
              {
                nixpkgs.overlays = [ nur.overlays.default ];
              }

              # Base configuration
              {
                home.username = "cameron";
                home.homeDirectory = "/home/cameron";
                home.stateVersion = "24.05";
                programs.home-manager.enable = true;
              }

              # Import all modules
              self.homeModules.shell
              self.homeModules.git
              self.homeModules.tmux
              self.homeModules.firefox
              self.homeModules.kitty
              self.homeModules.mic
              self.homeModules.packages-common
              self.homeModules.packages-gui
              self.homeModules.packages-linux
              self.homeModules.hyprland
            ];
          };
        };
      };
    };
}
