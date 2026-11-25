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
        Restart = "on-failure";
        StateDirectory = "kolibri";
        StateDirectoryMode = "0750";
        LogsDirectory = "kolibri";
        ProtectSystem = "full";
        ProtectHome = true;
        PrivateTmp = true;
        PrivateDevices = true;
        DevicePolicy = "closed";
        PrivateMounts = true;
        PrivateIPC = true;
        ProtectKernelTunables = true;
        ProtectKernelModules = true;
        ProtectKernelLogs = true;
        ProtectControlGroups = true;
        ProtectHostname = true;
        RemoveIPC = true;
        LockPersonality = true;
        RestrictRealtime = true;
        ProtectClock = true;
        MemoryDenyWriteExecute = true;
        RestrictAddressFamilies = [
          "AF_INET"
          "AF_INET6"
          "AF_NETLINK"
          "AF_UNIX"
        ];
        CapabilityBoundingSet = "";
        SystemCallFilter = [
          "@system-service"
        ];
        UMask = "0007";
        DeviceAllow = "";
        NoNewPrivileges = true;
        PrivateUsers = true;
        RestrictSUIDSGID = true;
        RuntimeDirectory = "kolibri";
        BindReadOnlyPaths = [
          builtins.storeDir
          "${config.security.pki.caBundle}:/etc/ssl/certs/ca-certificates.crt"
          "-/etc/resolv.conf"
        ] ++ lib.optionals config.services.resolved.enable [
          "/run/systemd/resolve/stub-resolv.conf"
          "/run/systemd/resolve/resolv.conf"  
        ];
      };
    };

    networking.firewall = lib.mkIf cfg.openFirewall {
      allowedTCPPorts = [ cfg.port ];
    };
  };
}
