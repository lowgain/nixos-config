{
  home.packages = with pkgs; [
    # Unixy tools
    sd
    tree
    tldr
    wget
    moreutils # ts, etc.
    killall

    # Terminal Utils
    cmatrix
    cbonsai
    neofetch
    usbutils
    pciutils

    # Compression
    p7zip
    unrar 

    # Networking
    traceroute
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
    ranger.enable = true;
    eza.enable = true;
    ripgrep.enable = true;
    television.enable = true;
    zoxide.enable = true;
  };
}