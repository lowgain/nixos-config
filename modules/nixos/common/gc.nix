{
  # Garbage collect the Nix store
  nix.gc = {
    automatic = true;
    dates = "weekly";
  };
  # Optimise the nix store
  nix.optimise = {
    automatic = true;
    dates = ["weekly"];
  };
}
