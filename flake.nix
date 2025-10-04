{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    sops-nix,
    ...
  }: {
    nixosConfigurations = {
      phantec = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          sops-nix.nixosModules.sops
          ./modules/secrets.nix
          ./hosts/phantec

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = null;
              extraSpecialArgs = inputs;
              users.ph = {
                imports = [
                  ./hosts/phantec/home
                  ./home
                ];
              };
            };
          }
        ];
      };

      phzenbook = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          sops-nix.nixosModules.sops
          ./hosts/phzenbook

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = null;
              extraSpecialArgs = inputs;
              users.ph = {
                imports = [
                  ./hosts/phzenbook/home
                  ./home
                ];
              };
            };
          }
        ];
      };
    };
  };
}
