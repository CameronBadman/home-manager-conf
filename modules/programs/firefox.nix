{ config, lib, pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
    
    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;
      
      search = {
        default = "ddg";
        force = true;
        engines = {
          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };
          "NixOS Wiki" = {
            urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
            iconUpdateURL = "https://nixos.wiki/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = [ "@nw" ];
          };
          "GitHub" = {
            urls = [{ template = "https://github.com/search?q={searchTerms}"; }];
            iconUpdateURL = "https://github.com/favicon.ico";
            definedAliases = [ "@gh" ];
          };
          "Arch Wiki" = {
            urls = [{ template = "https://wiki.archlinux.org/index.php?search={searchTerms}"; }];
            iconUpdateURL = "https://wiki.archlinux.org/favicon.ico";
            definedAliases = [ "@aw" ];
          };
        };
      };
      
      bookmarks = [
        {
          name = "Quick Access";
          toolbar = true;
          bookmarks = [
            {
              name = "Calendar";
              url = "https://calendar.google.com/calendar/u/0/r";
            }
            {
              name = "GitHub";
              url = "https://github.com/CameronBadman";
            }
            {
              name = "LinkedIn";
              url = "https://www.linkedin.com/in/cameron-badman-5314ba1b8/";
            }
            {
              name = "Outlook";
              url = "https://outlook.office.com/mail/";
            }
          ];
        }
        {
          name = "UQ";
          toolbar = true;
          bookmarks = [
            {
              name = "Dashboard";
              url = "https://portal.my.uq.edu.au/#/dashboard";
            }
            {
              name = "Exams";
              url = "https://mgt.exams.uq.edu.au/timetable/personal.php";
            }
            {
              name = "EAIT Projects";
              url = "https://internal.eait.uq.edu.au/projects/";
            }
            {
              name = "CSSE6400";
              url = "https://csse6400.uqcloud.net/";
            }
          ];
        }
        {
          name = "DevOps";
          toolbar = true;
          bookmarks = [
            {
              name = "AWS";
              url = "https://console.aws.amazon.com/";
            }
            {
              name = "GCloud";
              url = "https://console.cloud.google.com/";
            }
          ];
        }
        {
          name = "Learning";
          toolbar = true;
          bookmarks = [
            {
              name = "Exercism";
              url = "https://exercism.org/dashboard";
            }
            {
              name = "LeetCode";
              url = "https://leetcode.com/";
            }
            {
              name = "PortSwigger";
              url = "https://portswigger.net/web-security";
            }
          ];
        }
      ];
      
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        bitwarden
        privacy-badger
        decentraleyes
        clearurls
        skip-redirect
        darkreader
        sponsorblock
        return-youtube-dislikes
        enhanced-github
        refined-github
        vimium
      ];
      
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.startup.homepage" = "about:blank";
        "browser.newtabpage.enabled" = false;
        "browser.newtab.preload" = false;
        
        "signon.rememberSignons" = true;
        "signon.autofillForms" = true;
        "signon.generation.enabled" = true;
        
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "privacy.partition.network_state.ocsp_cache" = true;
        "browser.send_pings" = false;
        "dom.battery.enabled" = false;
        "geo.enabled" = false;
        "media.navigator.enabled" = false;
        
        "network.dns.disablePrefetch" = true;
        "network.prefetch-next" = false;
        "network.http.speculative-parallel-limit" = 0;
        
        "browser.safebrowsing.malware.enabled" = false;
        "browser.safebrowsing.phishing.enabled" = false;
        "browser.safebrowsing.downloads.enabled" = false;
        
        "dom.security.https_only_mode" = true;
        "dom.security.https_only_mode_ever_enabled" = true;
        
        "media.peerconnection.ice.default_address_only" = true;
        "media.peerconnection.ice.no_host" = true;
        "media.peerconnection.ice.proxy_only_if_behind_proxy" = true;
        
        "browser.tabs.firefox-view" = false;
        "browser.tabs.inTitlebar" = 0;
        "browser.uidensity" = 1;
        "browser.theme.dark-private-windows" = true;
        
        "widget.use-xdg-desktop-portal.file-picker" = 1;
        "widget.use-xdg-desktop-portal.mime-handler" = 1;
        
        "layers.acceleration.force-enabled" = true;
        "gfx.webrender.all" = true;
        "media.ffmpeg.vaapi.enabled" = true;
        "media.hardware-video-decoding.force-enabled" = true;
        
        "svg.context-properties.content.enabled" = true;
        "layout.css.color-mix.enabled" = true;
        "layout.css.backdrop-filter.enabled" = true;
        
        "browser.download.dir" = "/home/cameron/Downloads";
        "browser.download.folderList" = 1;
        "browser.download.useDownloadDir" = true;
        
        "browser.toolbars.bookmarks.visibility" = "always";
        "browser.urlbar.suggest.bookmark" = true;
        "browser.urlbar.suggest.history" = false;
        "browser.urlbar.suggest.openpage" = false;
        
        "browser.compactmode.show" = true;
        "browser.tabs.tabMinWidth" = 100;
        "browser.tabs.tabMaxWidth" = 220;
        
        "font.name.monospace.x-western" = "JetBrainsMono Nerd Font";
        "font.name.sans-serif.x-western" = "Inter";
        
        "browser.display.use_document_fonts" = 1;
        "layout.css.devPixelsPerPx" = "1.0";
      };
      
      userChrome = ''
        :root {
          --toolbar-bgcolor: #0D0D14 !important;
          --toolbar-color: #E8E4D0 !important;
          --tab-selected-bgcolor: #1A1A27 !important;
          --lwt-accent-color: #0D0D14 !important;
          --lwt-text-color: #E8E4D0 !important;
          --arrowpanel-background: #0D0D14 !important;
          --arrowpanel-color: #E8E4D0 !important;
          --urlbar-background-color: #12121C !important;
          --toolbar-field-background-color: #12121C !important;
          --toolbar-field-color: #E8E4D0 !important;
          --toolbar-field-focus-background-color: #1A1A27 !important;
          --tab-border-radius: 8px !important;
          --toolbarbutton-border-radius: 6px !important;
        }
        
        #navigator-toolbox {
          background-color: #0D0D14 !important;
          border: none !important;
        }
        
        #nav-bar {
          padding: 4px 8px !important;
          box-shadow: none !important;
        }
        
        .tab-background {
          border-radius: var(--tab-border-radius) var(--tab-border-radius) 0 0 !important;
          margin: 2px 2px 0 2px !important;
          background: #12121C !important;
          border: 1px solid #2A2A3A !important;
          transition: all 0.2s ease !important;
        }
        
        .tab-background[selected="true"] {
          background: linear-gradient(to bottom, #1A1A27 0%, #1A1A27 97%, #7AA2F7 97%, #7AA2F7 100%) !important;
          border-color: #3A3A4A !important;
          box-shadow: 0 -2px 12px rgba(122, 162, 247, 0.25) !important;
        }
        
        .tab-background:hover:not([selected="true"]) {
          background: #1A1A27 !important;
          border-color: #3A3A4A !important;
        }
        
        .tab-text {
          font-weight: 500 !important;
          color: #E8E4D0 !important;
        }
        
        .tab-text[selected="true"] {
          color: #FFFFFF !important;
        }
        
        #urlbar, #searchbar {
          border-radius: 8px !important;
          border: 2px solid #3A3A4A !important;
          padding: 4px 8px !important;
          transition: all 0.2s ease !important;
        }
        
        #urlbar:focus-within, #searchbar:focus-within {
          border-color: #7AA2F7 !important;
          box-shadow: 0 0 0 3px rgba(122, 162, 247, 0.3) !important;
        }
        
        #urlbar-background {
          border-radius: 8px !important;
        }
        
        toolbarbutton {
          border-radius: var(--toolbarbutton-border-radius) !important;
          transition: background 0.2s ease !important;
        }
        
        toolbarbutton:hover {
          background-color: #1A1A27 !important;
        }
        
        .tab-close-button {
          border-radius: 4px !important;
          transition: background 0.2s ease !important;
        }
        
        .tab-close-button:hover {
          background-color: #E82424 !important;
        }
        
        #PersonalToolbar {
          padding: 4px 8px !important;
          background-color: #12121C !important;
          border-top: 2px solid #2A2A3A !important;
        }
        
        .bookmark-item {
          border-radius: 6px !important;
          padding: 4px 8px !important;
          transition: background 0.2s ease !important;
          color: #E8E4D0 !important;
        }
        
        .bookmark-item:hover {
          background-color: #1A1A27 !important;
          color: #FFFFFF !important;
        }
        
        scrollbar {
          background-color: #0D0D14 !important;
          width: 10px !important;
        }
        
        scrollbar thumb {
          background-color: #3A3A4A !important;
          border-radius: 8px !important;
          transition: background 0.2s ease !important;
        }
        
        scrollbar thumb:hover {
          background-color: #4A4A5A !important;
        }
        
        #sidebar-box {
          background-color: #12121C !important;
          border-right: 2px solid #2A2A3A !important;
        }
        
        .sidebar-panel {
          background-color: #12121C !important;
          color: #E8E4D0 !important;
        }
        
        menupopup, menupopup > menu, menupopup > menuitem {
          background-color: #0D0D14 !important;
          color: #E8E4D0 !important;
          border-radius: 6px !important;
          border: 1px solid #2A2A3A !important;
        }
        
        menupopup > menu:hover, menupopup > menuitem:hover {
          background-color: #1A1A27 !important;
          color: #FFFFFF !important;
        }
      '';
      
      userContent = ''
        @-moz-document url-prefix(about:) {
          * {
            --in-content-page-background: #0D0D14 !important;
            --in-content-page-color: #E8E4D0 !important;
            --in-content-text-color: #E8E4D0 !important;
            --in-content-primary-button-background: #7AA2F7 !important;
            --in-content-primary-button-background-hover: #8AB4FF !important;
            --in-content-primary-button-background-active: #6A92E7 !important;
            --in-content-box-background: #12121C !important;
            --in-content-box-border-color: #3A3A4A !important;
          }
          
          body {
            scrollbar-width: thin !important;
            scrollbar-color: #3A3A4A #0D0D14 !important;
          }
        }
        
        @-moz-document url-prefix(about:newtab), url-prefix(about:home) {
          body {
            background-color: #0D0D14 !important;
          }
        }
        
        #urlbar-results {
          background-color: #0D0D14 !important;
          color: #E8E4D0 !important;
          border: 2px solid #3A3A4A !important;
        }
        
        .urlbarView-row {
          background-color: #12121C !important;
          color: #E8E4D0 !important;
        }
        
        .urlbarView-row:hover {
          background-color: #1A1A27 !important;
        }
        
        .urlbarView-row[selected] {
          background-color: #1A1A27 !important;
          border-left: 3px solid #7AA2F7 !important;
        }
        
        .urlbarView-url {
          color: #7AA2F7 !important;
        }
        
        .urlbarView-title {
          color: #E8E4D0 !important;
        }
        
        .urlbarView-title strong {
          color: #FFFFFF !important;
        }
        
        .urlbarView-secondary {
          color: #A0A0B0 !important;
        }
        
        .search-one-offs {
          background-color: #0D0D14 !important;
          border-top: 2px solid #3A3A4A !important;
        }
        
        .searchbar-engine-one-off-item {
          background-color: #12121C !important;
        }
        
        .searchbar-engine-one-off-item:hover {
          background-color: #1A1A27 !important;
        }
      '';
    };
  };
}
