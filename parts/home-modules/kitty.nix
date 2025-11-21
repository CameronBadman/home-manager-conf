{ config, lib, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    
    settings = {
      font_family = "JetBrainsMono Nerd Font";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      font_size = "11.0";
      
      background_opacity = "0.85";
      dynamic_background_opacity = "yes";
      
      window_padding_width = "5";
      
      cursor_shape = "block";
      cursor_blink_interval = "0.5";
      cursor_beam_thickness = "1.5";
      cursor_underline_thickness = "2.0";
      cursor_trail = "3";
      cursor_trail_decay = "0.1 0.4";
      
      scrollback_lines = "10000";
      
      mouse_hide_wait = "3.0";
      copy_on_select = true;
      
      enable_audio_bell = false;
      visual_bell_duration = "0.0";
      
      remember_window_size = true;
      initial_window_width = 1200;
      initial_window_height = 800;
      confirm_os_window_close = 0;
      
      repaint_delay = 10;
      input_delay = 3;
      sync_to_monitor = true;
      
      wayland_titlebar_color = "system";
      linux_display_server = "wayland";
      
      tab_bar_style = "hidden";
      
      foreground = "#c5c8c6";
      background = "#1d1f21";
      
      color0 = "#1d1f21";
      color1 = "#cc6666";
      color2 = "#b5bd68";
      color3 = "#f0c674";
      color4 = "#81a2be";
      color5 = "#b294bb";
      color6 = "#8abeb7";
      color7 = "#c5c8c6";
      
      color8 = "#666666";
      color9 = "#d54e53";
      color10 = "#b9ca4a";
      color11 = "#e7c547";
      color12 = "#7aa6da";
      color13 = "#c397d8";
      color14 = "#70c0b1";
      color15 = "#eaeaea";
      
      url_color = "#7aa6da";
    };
    
    keybindings = {
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
      
      "ctrl+plus" = "increase_font_size";
      "ctrl+minus" = "decrease_font_size";
      "ctrl+0" = "restore_font_size";
      
      "ctrl+shift+up" = "scroll_line_up";
      "ctrl+shift+down" = "scroll_line_down";
      "ctrl+shift+page_up" = "scroll_page_up";
      "ctrl+shift+page_down" = "scroll_page_down";
      
      "ctrl+shift+|" = "launch --location=vsplit";
      "ctrl+shift+_" = "launch --location=hsplit";
      
      "ctrl+shift+h" = "neighboring_window left";
      "ctrl+shift+l" = "neighboring_window right";
      "ctrl+shift+k" = "neighboring_window up";
      "ctrl+shift+j" = "neighboring_window down";
    };
    
    shellIntegration.enableBashIntegration = true;
  };
}
