# modules/bash.nix
{ config, lib, pkgs, ... }:
{
  programs.bash = {
    enable = true;
    
    initExtra = ''
      set -o vi
      bind -m vi-command 'Control-l: clear-screen'
      bind -m vi-insert 'Control-l: clear-screen'
      
      if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
        eval $(dbus-launch --sh-syntax)
      fi
      
      if [ -z "$SSH_AUTH_SOCK" ]; then
        eval $(ssh-agent -s) > /dev/null
        ssh-add ~/.ssh/github 2>/dev/null
      fi
      
      function set_prompt {
        local reset="\[\033[0m\]"
        local bold="\[\033[1m\]"
        local blue="\[\033[38;5;110m\]"
        local green="\[\033[38;5;150m\]"
        local yellow="\[\033[38;5;186m\]"
        local purple="\[\033[38;5;183m\]"
        
        local nix_indicator=""
        if [ -n "$IN_NIX_SHELL" ]; then
          nix_indicator=" ''${purple}❄''${reset}"
        fi
        
        PS1="''${bold}''${blue}\u''${reset}@''${bold}''${green}\h''${reset}''${nix_indicator} ''${yellow}\w''${reset}\n''${purple}❯''${reset} "
      }
      
      PROMPT_COMMAND=set_prompt
    '';
  };
}
