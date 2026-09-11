{
  description = "Irwan NixOS Setup";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix.url = "github:ryantm/agenix";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri.url = "github:epireyn/niri-flake";
    niri.inputs.nixpkgs.follows = "nixpkgs";

    # nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel";

    catppuccin.url = "github:catppuccin/nix";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lazyvim.url = "github:pfassina/lazyvim-nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      agenix,
      catppuccin,
      lazyvim,
      niri,
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
              lazyvim.homeManagerModules.default
              ./home/home.nix
              inputs.catppuccin.homeModules.catppuccin
              niri.homeModules.config
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
          {
            nixpkgs.overlays = [ inputs.nur.overlays.default ];
          }
          ./hosts/toshiba/configuration.nix
          home-manager.nixosModules.home-manager
          agenix.nixosModules.default
          hmModule
        ];
      };
    };
}
