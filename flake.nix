{
	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";
		disko.url = "github:nix-community/disko";
		disko.inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs = inputs @ { self, nixpkgs, ... }: let
		inherit (self) outputs;
		lib = nixpkgs.lib;
	in {
		nixosConfigurations = {
			gnida = lib.nixosSystem {
				specialArgs = { inherit inputs outputs; };
				modules = [ ./machines/gnida ];
			};
		};
	};
}
