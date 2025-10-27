{
  description = "Omarchy-style NixOS + Home Manager setup (Hyprland, Waybar, flakes)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
  in {
    # Make sure flakes are on even in bare shells
    nixConfig = {
      extra-experimental-features = [ "nix-command" "flakes" ];
    };

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./hosts/nixos/configuration.nix

        # Home Manager as a NixOS module
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.ktsop = import ./home/ktsop/home.nix;
        }
      ];
    };
  };
}
