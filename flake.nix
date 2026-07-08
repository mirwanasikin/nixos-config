{
  description = "Irwan NixOS Setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # nixpkgs.url = "github:NixOS/nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia-v5 = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix.url = "github:ryantm/agenix";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel";

    catppuccin.url = "github:catppuccin/nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      agenix,
      catppuccin,
      noctalia-v5,
      ...
    }@inputs:
    let
      hmModule = {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "backup";
          extraSpecialArgs = { inherit inputs agenix; };
          users.irwan = {
            imports = [
              ./home/home.nix
              inputs.catppuccin.homeModules.catppuccin
              inputs.noctalia-v5.homeModules.default
            ];
          };
        };
      };
    in
    {
      nixosConfigurations.toshiba = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs agenix; };
        modules = [
          ./hosts/toshiba/configuration.nix
          home-manager.nixosModules.home-manager
          agenix.nixosModules.default
          hmModule
        ];
      };
    };
}
