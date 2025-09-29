{pkgs, ...}: {
  home.packages = with pkgs; [
    # Unixy tools
    tree
    tlrc
    wget

    # Screensaver utils
    cmatrix
    cbonsai
    fastfetch

    # Compression
    p7zip
    unrar

    # Networking
    inetutils
    nmap
    speedtest-cli
  ];

  # Programs natively supported by home-manager.
  # They can be configured in `programs.*` instead of using home.packages.
  programs = {
    bat.enable = true;
    fd.enable = true;
    fzf.enable = true;
    btop.enable = true;
    htop.enable = true;
    eza.enable = true;
    ripgrep.enable = true;
    television.enable = true;
    zoxide.enable = true;
  };
}
