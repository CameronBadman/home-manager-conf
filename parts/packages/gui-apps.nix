{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    # Communication
    legcord
    vesktop

    # Media
    spotify
    obsidian

    # Tools
    google-chrome

  ];
}
