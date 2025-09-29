{
  pkgs,
  flake,
  ...
}: {
  home.packages = with pkgs; [
    git-filter-repo
  ];

  programs.git = {
    enable = true;
    userName = flake.config.me.username;
    userEmail = flake.config.me.email;
    extraConfig.safe.directory = "*";
    ignores = [
      "*~"
      "*.swp"
    ];
  };

  programs.lazygit = {
    enable = true;
    settings = {
      # This looks better with the kitty theme.
      gui.theme = {
        lightTheme = false;
        activeBorderColor = [
          "white"
          "bold"
        ];
        inactiveBorderColor = ["white"];
        selectedLineBgColor = [
          "reverse"
          "white"
        ];
      };
    };
  };
}
