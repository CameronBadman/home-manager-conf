# modules/waybar.nix
{ config, lib, pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    systemd.enable = false;
    
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        spacing = 2;
        margin-top = 2;
        margin-bottom = 2;
        
        modules-left = [ "hyprland/workspaces" "hyprland/window" ];
        modules-center = [ "clock" ];
        modules-right = [ "mpris" "idle_inhibitor" "wireplumber" "network" "cpu" "memory" "custom/gpu" "temperature" "tray" ];

        "hyprland/workspaces" = {
          disable-scroll = false;
          all-outputs = false;
          format = "{id}";
          sort-by-number = true;
          active-only = false;
          on-click = "activate";
        };

        "hyprland/window" = {
          max-length = 60;
          separate-outputs = true;
          rewrite = {
            "(.*) - Google Chrome" = " $1";
            "nvim (.*)" = " $1";
            "(.*) - Spotify" = "󰓇 $1";
            "(.*) - Legcord" = "󰙯 $1";
          };
        };

        clock = {
          format = " {:%I:%M %p | %a %d %b}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "%B";
              days = "%d";
              weeks = "%V";
              weekdays = "%a";
              today = "<span color='#ff9e64'><b>%d</b></span>";
            };
          };
        };

        cpu = {
          format = "󰻠 {usage}%";
          interval = 5;
          tooltip = true;
        };

        memory = {
          format = "󰍛 {}%";
          tooltip-format = "{used:0.1f}GB used";
        };

        "custom/gpu" = {
          exec = "cat /sys/class/drm/card0/device/gpu_busy_percent";
          format = "󰢮 {}%";
          interval = 5;
          tooltip = true;
          return-type = "";
        };

        temperature = {
          hwmon-path = "/sys/class/hwmon/hwmon3/temp1_input";
          critical-threshold = 90;
          format-critical = " {temperatureC}°C";
          format = " {temperatureC}°C";
          interval = 5;
          tooltip = true;
          tooltip-format = "CPU Temperature: {temperatureC}°C";
        };

        network = {
          format-wifi = "󰖩 {essid} ({signalStrength}%)";
          format-ethernet = "󰈀 {ipaddr}/{cidr}";
          tooltip-format = "{ifname} via {gwaddr}";
          format-linked = "{ifname} (No IP)";
          format-disconnected = "󰖪 Disconnected";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
          interval = 5;
        };

        wireplumber = {
          format = "{icon} {volume}%";
          format-muted = "󰖁";
          format-icons = [ "󰕿" "󰖀" "󰕾" ];
          scroll-step = 1;
          on-click = "pavucontrol";
          tooltip-format = "{node_name}";
        };

        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
          tooltip-format-activated = "Idle inhibitor: ON";
          tooltip-format-deactivated = "Idle inhibitor: OFF";
        };
        
        mpris = {
          format = "{player_icon} {dynamic}";
          format-paused = "{status_icon} {dynamic}";
          player-icons = {
            default = "▶";
            spotify = "󰓇";
            firefox = "󰈹";
            chromium = "";
            vlc = "󰕼";
          };
          status-icons = {
            paused = "⏸";
            stopped = "⏹";
          };
          dynamic-order = [ "artist" "title" ];
          dynamic-importance = [ "artist" "title" ];
          dynamic-len = 30;
          max-length = 40;
          interval = 5;
          on-click = "playerctl play-pause";
          on-click-right = "playerctl next";
          on-click-middle = "playerctl previous";
          on-scroll-up = "playerctl volume 0.05+";
          on-scroll-down = "playerctl volume 0.05-";
          tooltip-format = "{player}: {artist} - {title}";
        };

        tray = {
          icon-size = 16;
          spacing = 5;
          tooltip = true;
        };
      };
    };

    style = ''
      * {
          border: none;
          border-radius: 0;
          font-family: "FiraCode Nerd Font", "JetBrainsMono Nerd Font";
          font-size: 12px;
          min-height: 0;
          transition-property: background-color;
          transition-duration: 0.3s;
      }

      window#waybar {
          background: rgba(22, 22, 29, 0.9);
          color: #dcd7ba;
          border-radius: 0px;
          border-bottom: 2px solid rgba(114, 122, 137, 0.3);
      }

      window#waybar.hidden {
          opacity: 0.2;
      }

      #workspaces button {
          padding: 0 8px;
          margin: 2px 2px;
          color: #727169;
          border-radius: 6px;
          transition: all 0.3s ease;
          background: transparent;
          border-bottom: 3px solid transparent;
          min-width: 30px;
          font-weight: bold;
      }

      #workspaces button.active {
          color: #16161d;
          background: #7e9cd8;
          border-radius: 6px;
          min-width: 30px;
          box-shadow: rgba(0, 0, 0, 0.3) 0 2px 4px;
          border-bottom: 3px solid #7fb4ca;
          font-weight: bold;
      }

      #workspaces button:hover {
          background: rgba(126, 156, 216, 0.2);
          color: #dcd7ba;
          border-radius: 6px;
          border-bottom: 3px solid #7e9cd8;
      }

      #workspaces button.urgent {
          background: #e82424;
          color: #dcd7ba;
          animation: blink 1s infinite;
      }

      #window,
      #clock,
      #cpu,
      #memory,
      #custom-gpu,
      #temperature,
      #network,
      #wireplumber,
      #idle_inhibitor,
      #tray,
      #mpris {
          padding: 0 10px;
          margin: 2px 4px;
          color: #dcd7ba;
          border-radius: 8px;
          background: rgba(54, 54, 68, 0.8);
          border: 1px solid rgba(114, 122, 137, 0.2);
      }

      #window {
          background: rgba(147, 153, 178, 0.15);
          border: 1px solid rgba(147, 153, 178, 0.3);
          min-width: 200px;
      }

      #clock {
          min-width: 180px;
          background: rgba(126, 156, 216, 0.15);
          border: 1px solid rgba(126, 156, 216, 0.3);
          font-weight: bold;
      }

      #cpu {
          background: rgba(255, 160, 102, 0.15);
          border: 1px solid rgba(255, 160, 102, 0.3);
      }

      #memory {
          background: rgba(154, 217, 177, 0.15);
          border: 1px solid rgba(154, 217, 177, 0.3);
      }

      #custom-gpu {
          background: rgba(118, 186, 242, 0.15);
          border: 1px solid rgba(118, 186, 242, 0.3);
      }

      #temperature {
          background: rgba(255, 158, 100, 0.15);
          border: 1px solid rgba(255, 158, 100, 0.3);
          font-weight: bold;
      }

      #temperature.critical {
          background: #e82424;
          color: #dcd7ba;
          animation: blink 1s infinite;
          font-weight: bold;
      }

      #network {
          background: rgba(147, 153, 178, 0.15);
          border: 1px solid rgba(147, 153, 178, 0.3);
      }

      #network.disconnected {
          background: rgba(232, 36, 36, 0.15);
          border: 1px solid rgba(232, 36, 36, 0.3);
      }

      #wireplumber {
          background: rgba(214, 188, 249, 0.15);
          border: 1px solid rgba(214, 188, 249, 0.3);
      }

      #wireplumber.muted {
          background: rgba(114, 122, 137, 0.3);
          color: #727169;
      }

      #mpris {
          padding: 0 12px;
          margin: 2px 4px;
          background: rgba(154, 217, 177, 0.15);
          border: 1px solid rgba(154, 217, 177, 0.3);
          min-width: 200px;
      }

      #mpris.paused {
          background: rgba(114, 122, 137, 0.15);
          border: 1px solid rgba(114, 122, 137, 0.3);
      }

      #idle_inhibitor {
          background: rgba(192, 163, 110, 0.15);
          border: 1px solid rgba(192, 163, 110, 0.3);
      }

      #idle_inhibitor.activated {
          background: #c0a36e;
          color: #16161d;
          font-weight: bold;
      }

      #tray {
          background: rgba(54, 54, 68, 0.8);
          border: 1px solid rgba(114, 122, 137, 0.2);
      }

      @keyframes blink {
          0% { opacity: 1; }
          50% { opacity: 0.3; }
          100% { opacity: 1; }
      }

      tooltip {
          background: rgba(22, 22, 29, 0.95);
          border: 1px solid rgba(114, 122, 137, 0.4);
          border-radius: 8px;
      }

      tooltip label {
          color: #dcd7ba;
          padding: 6px;
          font-size: 11px;
      }
    '';
  };

  home.packages = with pkgs; [
    playerctl
  ];
}
