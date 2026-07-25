{
  self,
  inputs,
  ...
}: {
  # Nixos user configuration
  flake.nixosModules.lowgainModule = {
    imports = [ self.nixosModules.myHomeManager ];
    users.users.lowgain = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ];
      home = "/home/lowgain";
      initialPassword = "Lowgain";
    };
    home-manager.users.lowgain = self.homeModules.lowgainModule;
  };

  # This is your standalone home-manager configuration, meant to be used on non-nixos machines
  # with the home-manager command
  flake.homeConfigurations.lowgain = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs {system = "x86_64-linux";};
    modules = [
      self.homeModules.lowgainModule
    ];
  };

  # This is your home.nix, your module where you configure home-manager
  # It's imported both in standalone configuration above, and in your nixos configuration
  flake.homeModules.lowgainModule = {pkgs, ...}: {
    imports = [
      self.homeModules.shell
    ];

    home = {
      username = "lowgain";
      homeDirectory = "/home/lowgain";
      stateVersion = "26.05";
      packages = with pkgs; [
        net-tools
        util-linux
        coreutils-full
        nmap
        traceroute
        inetutils
        usbutils
        pciutils
      ];
    };

    programs.git.settings = {
      user = {
        name = "Lowgain";
        email = "logan.t2020@tutanota.com";
      };
    };
  };
}
