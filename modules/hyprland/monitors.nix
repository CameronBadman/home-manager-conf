{ config, lib, pkgs, ... }:
{
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "DP-2,preferred,0x0,1"
      "DP-1,preferred,auto-right,1"
      ",preferred,auto,1"
    ];
  };
}
