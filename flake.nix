{
  description = "a nix config";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs"; 
    };
  };
  outputs = { self, ... }@inputs: {
    nixosConfigurations.three = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
       inputs.home-manager.nixosModules.home-manager
       ./system/software.nix
       ./system/system.nix
       ./user/software.nix
      ];
    };
  };
}
