{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    # CLI Tools
    git
    ripgrep
    neofetch
    ncurses
    gnumake

    # Terminal
    tmux

    # Development
    gh
    awscli2
    pnpm
    claude-code
  ];
}
