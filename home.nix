{ config, pkgs, inputs, ... }:
{
  imports = [
    ./modules
  ];
  
  nixpkgs.overlays = [ inputs.nur.overlay ];
  
  home.username = "cameron";
  home.homeDirectory = "/home/cameron";
  home.stateVersion = "24.05";

  # home-manager switch --flake ~/.config/home-manager#cameron --impure 
  programs.home-manager.enable = true;
}
