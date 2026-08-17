{
  flake.homeModules.desktop = {
    programs.qutebrowser = {
      enable = true;
      searchEngines = {
        nw = "https://wiki.nixos.org/index.php?search={}";
        np = "https://search.nixos.org/packages?channel=unstable&query={}";
        no = "https://search.nixos.org/options?channel=unstable&query={}";
        b = "https://search.brave.com/search?q={}";
      };
    };
  };
}
