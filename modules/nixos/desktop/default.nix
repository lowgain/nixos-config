{ flake, pkgs, ... }:

let
  inherit (flake) config;
in
{
  imports =
    with builtins;
    map (fn: ./${fn}) (filter (fn: fn != "default.nix") (attrNames (readDir ./.)));

  # Enable CUPS for printing
  services.printing.enable = true;

  # Enable scanning support
  hardware.sane.enable = true;
  users.users."${config.me.username}".extraGroups = [
    "scanner"
    "lp"
  ];

  # Enable Udisks2 for usb storage devices
  services.udisks2.enable = true;

  # Enable yubikey support
  services.yubikey-agent.enable = true;
  programs.yubikey-touch-detector.enable = true;
  services.udev.packages = [ pkgs.yubikey-personalization ];
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Enable MTR a network tool
  programs.mtr.enable = true;
}
