{ config, pkgs, ... }:

{
  imports = [
    ./git.nix
    ./kitty.nix
    ./ssh.nix
    ./tmux.nix
    ./shell.nix
    ./firefox.nix
    ./mic.nix
  ];
}
