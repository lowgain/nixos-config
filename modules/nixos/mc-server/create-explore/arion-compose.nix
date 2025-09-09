{
  project.name = "mc";
  services.mc.service = {
    name = "mc";
    image = "itzg/minecraft-server:stable-java21-graalvm";
    volumes = [ "/opt/minecraft/create-explore/data:/data" ];
    tty = true;
    ports = [ "25565:25565" ];
    restart = "always";
    environment = {
      EULA =  "TRUE";
      RCON_PASSWORD: "Password";
      BROADCAST_RCON_TO_OPS: "TRUE";
      TYPE =  "NEOFORGE";
      VERSION =  "1.21.1";
      NEOFORGE_VERSION =  "21.1.208";
      PACKWIZ_URL =  "https://lowgain.github.io/create-explore-modpack/pack.toml";
      VANILLATWEAKS_SHARECODE = "6gI6Xi, 3489Fl";
      MEMORY =  "5G";
      MOTD =  "THE JONESER CONVENTION CREATE EXPLORE";
      WHITELIST =  "papa_marshmellow";
      OPS =  "papa_marshmellow";
    };
  };
}