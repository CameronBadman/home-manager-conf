{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    swww
  ];
  
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "swww-daemon"
    ];
  };
}
