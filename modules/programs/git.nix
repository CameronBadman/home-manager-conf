# modules/git.nix
{ config, lib, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "Cameron Badman";
    userEmail = "cbadwork@gmail.com";
    
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      core.editor = "nvim";
      
      credential.helper = "store";
      
      color = {
        ui = "auto";
        branch = "auto";
        diff = "auto";
        status = "auto";
      };
    };
    
  };
  
  programs.ssh = {
    enable = true;
    
    extraConfig = ''
      Host github.com
        HostName github.com
        User git
        IdentityFile ~/.ssh/github
        AddKeysToAgent yes
    '';
  };
  
  home.packages = with pkgs; [
    gh
  ];
}
