{inputs, ...}: {
  flake.nixosModules.noctalia = {
    imports = [
      inputs.noctalia.nixosModules.default
    ];
    services.logind.settings.Login = {
      HandlePowerKey = "ignore";
      HandleSuspendKey = "ignore";
      HandleHibernateKey = "ignore";
      HandleLidSwitch = "ignore";
      HandleLidSwitchDocked = "ignore";
    };
    programs.noctalia = {
      enable = true;
      recommendedServices.enable = true;
    };
  };
}
