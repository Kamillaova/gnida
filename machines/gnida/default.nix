{ inputs, lib, pkgs, ... }: {
	imports = [
		./disko-config.nix
		inputs.disko.nixosModules.disko
	];

	boot.initrd.availableKernelModules = [ "nvme" ];
	boot.kernelModules = [ "kvm-amd" ];

	boot.loader = {
		systemd-boot = {
			enable = true;
			consoleMode = "max";
		};
		efi.canTouchEfiVariables = true;
	};

	networking.useDHCP = lib.mkDefault false;

	environment.systemPackages = with pkgs; [
		tcpdump
		htop
	];

	networking.bridges = {
		"br0" = {
			interfaces = [ "enp0s3" ];
			rstp = true;
		};
	};

	networking.interfaces.br0 = {
		useDHCP = true;
	};

	services.openssh = {
		enable = true;
		settings = {
			PasswordAuthentication = true;
			PermitRootLogin = "yes";
		};
	};

	virtualisation.virtualbox.guest.enable = true;

	nixpkgs.hostPlatform = "x86_64-linux";
	system.stateVersion = "23.05";
}
