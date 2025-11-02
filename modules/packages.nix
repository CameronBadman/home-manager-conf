{ config, pkgs, inputs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  
  home.packages = with pkgs; [
    inputs.nixgl.packages.${pkgs.system}.nixGLDefault
    hyprland
    waybar
    wofi
    git
    legcord
    ripgrep
    networkmanagerapplet
    spotify
    nwg-displays
    vesktop
    obsidian
    neofetch
    ncurses
    nautilus
    gnumake
    awscli2
    kdePackages.kdenlive
    google-chrome
    amdgpu_top
    pnpm
    texstudio
    
    (obs-studio.override {
      pipewireSupport = true;
    })
    alsa-plugins
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk

    claude-code
    
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.jetbrains-mono
  ];

  xdg.configFile."pipewire/pipewire.conf.d/92-low-latency.conf".text = ''
    context.properties = {
      default.clock.rate = 48000
      default.clock.quantum = 1024
      default.clock.min-quantum = 512
      default.clock.max-quantum = 2048
    }
  '';
  
  xdg.configFile."xdg-desktop-portal/hyprland-portals.conf".text = ''
    [preferred]
    default=hyprland;gtk
    org.freedesktop.impl.portal.ScreenCast=hyprland
    org.freedesktop.impl.portal.Screenshot=hyprland
  '';
}
