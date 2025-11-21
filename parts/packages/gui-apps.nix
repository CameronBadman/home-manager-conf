{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    # Communication
    vesktop

    # Media
    spotify
    obsidian

    # Tools
    google-chrome

  ];
}
