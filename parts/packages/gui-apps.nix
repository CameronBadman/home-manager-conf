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

    # Creative
    kdePackages.kdenlive
    texstudio

    # Gaming
    prismlauncher

    # OBS with pipewire support
    (obs-studio.override {
      pipewireSupport = true;
    })
  ];
}
