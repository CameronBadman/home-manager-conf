{ config, pkgs, inputs, lib, ... }:
{
  # Import neovim from external flake
  # This requires the nvim-flake input to be available
  home.packages = lib.mkMerge [
    # Add the main neovim package based on system
    (lib.mkIf (pkgs.system == "x86_64-linux") [
      inputs.nvim-flake.packages.x86_64-linux.default
    ])
    (lib.mkIf (pkgs.system == "aarch64-darwin") [
      inputs.nvim-flake.packages.aarch64-darwin.default
    ])
    (lib.mkIf (pkgs.system == "x86_64-darwin") [
      inputs.nvim-flake.packages.x86_64-darwin.default
    ])
    # Add extra packages required by neovim config
    (inputs.nvim-flake.extraPackages pkgs)
  ];
}
