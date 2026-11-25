{
  lib,
  config,
  pkgs,
  ...
}:

let
  cfg = config.services.kolibri;
in {
  options = {
    services.kolibri = {
      enable = lib.mkEnableOption "Enables the Kolibri Server Service.";

      package = lib.mkPackageOption pkgs "kolibri" { };

      port = lib.mkOption {
        type = lib.types.port;
        default = 8080;
        description = "Port to listen on";
      };

      openFirewall = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Open port in the firewall for kolibri.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.kolibri = {
      enable = true;
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      description = "Kolibri Server Service";
      environment = {
        KOLIBRI_HOME = "/var/lib/kolibri";
      };
      serviceConfig = {
        Type = "simple";
        DynamicUser = true;
        ExecStart = ''${lib.getExe' cfg.package "kolibri"} start --port ${lib.toString cfg.port} --foreground'';
        ExecStop = ''${lib.getExe' cfg.package "kolibri"} stop'';
        StateDirectory = "kolibri";
        StateDirectoryMode = "0750";
        # RuntimeDirectory = "kolibri";
        # RootDirectory = "/run/kolibri";
        LogsDirectory = "kolibri";
        Restart = "on-failure";
      };
    };

    networking.firewall = lib.mkIf cfg.openFirewall {
      allowedTCPPorts = [ cfg.port ];
    };
  };
}
