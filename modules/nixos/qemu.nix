{
  flake.nixosModules.qemu = {pkgs, ...}: {
    systemd.tmpfiles.rules = ["L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware"];
    virtualisation = {
      libvirtd = {
        enable = true;
        qemu.swtpm.enable = true; # Enable TPM emulation (for Windows 11)
      };
      spiceUSBRedirection.enable = true;
    };

    users.groups = {
      libvirtd.members = ["lowgain"];
      kvm.members = ["lowgain"];
    };

    networking.firewall.trustedInterfaces = ["virbr0"];

    environment.systemPackages = with pkgs; [
      gnome-boxes # GUI Frontend
      dnsmasq # Enables networking
      phodav # File sharing
      qemu
      quickemu
    ];
  };
}
