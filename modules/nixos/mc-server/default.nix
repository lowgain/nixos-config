{ pkgs, ... }:

{
  users.users."minecraft" = {
    initialPassword = "minecraft";
    isSystemUser = true;
    extraGroups = [ "wheel" "podman" ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDHrPDPwfjoUwtWw10ztsiI6JVtKEgbmFlOsM0Xc/DiGdgOnAXY5UkNtrgalxlQAUTZQFlSCzW7KLYCAhXkyRt946qqWzqKdLXpyWeKdgcStLUV5pm41zjtenVx9001zGiL4emWy8exZQkIzdaO0084aB3j8TjnzNfmA8z2K2QandbAIaBrwkcKfBaLaJFOpsPav83950QtQeQPLBwwP8ZqX+gGjXvZxVmcVGabXDBhEXEwdGHnFZexChSYotagr1yBZnNLgutjF03DVzAZLSy80gqWysMCXUxEnALX4ByB1CiiSWFHchxCnUjZLDisLs4voG0rqWaRGaIC6cAH+MSDcpwYoK2LauSuDgJdhgouzddNL7RTfZrA7lpVjg6Ac4SM/vulFRoMcwip9D6n+pTca+8LEaw4Bj9rPYZNDBv1U6cQmSeUEJIptUaJeOQiNnfxTul7Orq6WxE738up1h8s+8DJb6GyvcwToNvvF3j640vQiMs7UKsdp6bv8fD4qbUxDq68cx6GKOg5d0VPeybf7AIsMbimrhbAYXV+xrJi4dEBwtxP4eidYhGKJgTEavT7yR+fQnq32oVWhRGMTktuw7mqsGBniw1VWR9pWIjA9WXH/zLEjDePrBXD2JL66TfDe1QhzI8wsmetvVrVt/P93Xmwy0RsHR0jBVwqTnb9Ow== lowgain@nixos-wsl"
    ];
  };

  environment.systemPackages = [ pkgs.arion pkgs.docker-client ];
  networking.firewall.allowedTCPPorts = [ 25565 ];

  # Arion works with Docker, but for NixOS-based containers, you need Podman
  # since NixOS 21.05.
  virtualisation.docker.enable = false;
  virtualisation.podman.enable = true;
  virtualisation.podman.dockerSocket.enable = true;
  virtualisation.podman.defaultNetwork.dnsname.enable = true;
}