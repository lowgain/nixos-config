{pkgs, ...}: {
  hjem.users.lowgain = {
    clobberFiles = true;
    environment = {
      sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
      };
    };
    xdg.config.files = {
      "nvim/init.lua".source = ./dotfiles/nvim/init.lua;
    };
    packages = with pkgs; [
      neovim
      librewolf-bin
      libreoffice
      hunspell
      hunspellDicts.en_US
      hyphenDicts.en_US
      simple-scan
      pdfarranger
      (mpv.override {
        mpv-unwrapped = mpv-unwrapped.override {
          waylandSupport = true;
          vapoursynthSupport = true;
        };
        youtubeSupport = true;
        scripts = with mpvScripts; [
          mpris
          sponsorblock
          youtube-upnext
          uosc
        ];
      })
      libqalculate
      qbittorrent
    ];
  };

  fonts = {
    packages = with pkgs; [
      atkinson-hyperlegible-next
      nerd-fonts.atkynson-mono
    ];
  };
}
