{ pkgs, ... }:
{
  enable = true;
  package = pkgs.paperServers.paper-1_21_8;
  jvmOpts = "-Xmx5G -Xms1G ";
  autoStart = true;
  whitelist = {
    papa_marshmellow = "4adb0532-3d7c-4019-a26e-09fe7900c99c";
  };
  serverProperties = {
    server-port = 25565;
    difficulty = 3;
    motd = "Joneser Convention";
    white-list = true;
    simulation-distance = 4;
    view-distance = 7;
  };
  symlinks."ops.json" = {
    value = [
      {
        uuid = "4adb0532-3d7c-4019-a26e-09fe7900c99c";
        name = "papa_marshmellow";
        level = "4";
        bypassesPlayerLimit = "true";
      }
    ];
  };
}
