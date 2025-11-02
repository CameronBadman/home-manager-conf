{
  description = "Cameron's Home Manager Configuration";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    nvim-flake = {
      url = "github:CameronBadman/Nvim-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";
  };
  
  outputs = { nixpkgs, home-manager, nvim-flake, nixgl, ... }@inputs: {
    homeConfigurations.cameron = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      
      modules = [
        ./home.nix
        
        { _module.args = { inherit inputs; }; }
        
        ({ pkgs, ... }: {
          home.packages = [
            nvim-flake.packages.x86_64-linux.default
          ] ++ (nvim-flake.extraPackages pkgs);
        })
      ];
    };
  };
}
