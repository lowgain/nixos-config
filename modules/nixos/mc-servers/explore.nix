{
  pkgs,
  lib,
  ...
}: let
  modpack = pkgs.fetchPackwizModpack {
    url = "https://raw.githubusercontent.com/lowgain/explore-modpack/refs/tags/v0.0.1/pack.toml";
    packHash = "sha256-L++GLaX/pdxq8TTgyepCLl/QntnM/3v7iy+2GZukBHI=";
  };
  mcVersion = modpack.manifest.versions.minecraft;
  fabricVersion = modpack.manifest.versions.fabric;
  serverVersion = lib.replaceStrings ["."] ["_"] "fabric-${mcVersion}";
in {
  services.minecraft-servers.servers.explore-modpack = {
    enable = true;
    autoStart = true;
    restart = "always";
    package = pkgs.fabricServers.${serverVersion}.override {loaderVersion = fabricVersion;};
    whitelist = {
      papa_marshmellow = "4adb0532-3d7c-4019-a26e-09fe7900c99c";
    };
    operators = {
      papa_marshmellow = {
        uuid = "4adb0532-3d7c-4019-a26e-09fe7900c99c";
        level = 4;
        bypassesPlayerLimit = true;
      };
    };
    serverProperties = {
      difficulty = 3;
      motd = "The Joneser Convention";
      white-list = true;
      enable-rcon = true;
      "rcon.password" = "pa55word";
      broadcast-rcon-to-ops = true;
      broadcast-console-to-ops = true;
      allow-flight = true;
      enable-command-block = true;
      sync-chunk-writes = false;
      max-chained-neighbor-updates = 10000;
      max-world-size = 10000;
      simulation-distance = 9;
      spawn-protection = 0;
      pause-when-empty-seconds = -1;
    };
    jvmOpts = "-Xms3072M -Xmx3584M";
    symlinks = {
      "mods" = "${modpack}/mods";
    };
    files = {
      "config" = "${modpack}/config";
    };
  };

  # Open port for Simple Voice Chat
  networking.firewall.allowedUDPPorts = [24454];
}
