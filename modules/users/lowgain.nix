{
  flake.nixosModules.lowgainModule = {
    users.users.lowgain = {
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager" "scanner" "lp"];
      home = "/home/lowgain";
      initialPassword = "Lowgain";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMjw3UlPY0SebTuJ2/tDl1IMcOeJP7pBdGU29IVRbfyB logan.t2020@tutanota.com"
      ];
    };
  };

  flake.homeModules.lowgainModule = {pkgs, ...}: {
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
        tree
        btop
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
