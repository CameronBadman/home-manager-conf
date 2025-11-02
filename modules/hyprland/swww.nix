{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    swww
    mpvpaper
  ];
  
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "mpvpaper -o 'no-audio loop hwdec=auto' '*' ~/wallpaper/wallpaper_1440p.mp4"
    ];
  };
}
