{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    # Gaming
    prismlauncher
  ];
}
