{ config, pkgs, inputs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # nixGL for OpenGL support
    inputs.nixgl.packages.${pkgs.system}.nixGLDefault

    # Hyprland ecosystem
    hyprland
    waybar
    wofi

    # Linux system tools
    networkmanagerapplet
    nwg-displays
    nautilus
    amdgpu_top

    # Audio
    alsa-plugins

    # Portals
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk

    (obs-studio.override {
      pipewireSupport = true;
    })

    # Fonts
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.jetbrains-mono
  ];

  # Pipewire low-latency configuration
  xdg.configFile."pipewire/pipewire.conf.d/92-low-latency.conf".text = ''
    context.properties = {
      default.clock.rate = 48000
      default.clock.quantum = 1024
      default.clock.min-quantum = 512
      default.clock.max-quantum = 2048
    }
  '';

  # XDG Portal configuration
  xdg.configFile."xdg-desktop-portal/hyprland-portals.conf".text = ''
    [preferred]
    default=hyprland;gtk
    org.freedesktop.impl.portal.ScreenCast=hyprland
    org.freedesktop.impl.portal.Screenshot=hyprland
  '';
}
