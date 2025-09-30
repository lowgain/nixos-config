{
  languages.nix.enable = true;

  git-hooks.hooks = {
    # Nix
    alejandra.enable = true;
    deadnix.enable = true;
    statix.enable = true;
    flake-checker.enable = true;

    # Git
    commitizen.enable = true;

    # Spelling
    typos.enable = true;
  };
}
