{ pkgs, ... }:
{
  home.shellAliases = {
    ".." = "cd ..";
    "..." = "cd ../..";
    "find" = "fd";
    "ls" = "eza";
    "ll" = "eza -l";
    "la" = "eza -la";
    "grep" = "rg";
    "cd" = "z";
    "cat" = "bat";
  };

  programs = {
    bash = {
      enable = true;
      enableCompletion = true;
    };

    # Better shell prompt!
    starship = {
      enable = true;
      settings = {
        username = {
          style_user = "blue bold";
          style_root = "red bold";
          format = "[$user]($style) ";
          disabled = false;
          show_always = true;
        };
        hostname = {
          ssh_only = false;
          ssh_symbol = "🌐 ";
          format = "@ [$hostname](bold red) ";
          trim_at = ".local";
          disabled = false;
        };
      };
    };
  };
}
