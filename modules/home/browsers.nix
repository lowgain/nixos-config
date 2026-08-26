{
  flake.homeModules.browsers = {pkgs, ...}: {
    programs = {
      qutebrowser = let
        filepicker = [
          "foot"
          "-e"
          "lf"
          "-command"
          "set nohidden"
          "-selection-path={}"
        ];
      in {
        enable = true;
        package = pkgs.qutebrowser.override {
          enableWideVine = true;
          enableVulkan = true;
        };
        searchEngines = {
          DEFAULT = "https://search.brave.com/search?q={}";
          nw = "https://wiki.nixos.org/w/index.php?search={}";
          np = "https://search.nixos.org/packages?channel=unstable&query={}";
          no = "https://search.nixos.org/options?channel=unstable&query={}";
          yt = "https://inv.nadeko.net/search?q={}";
        };
        quickmarks = {
          cheat-sheet = "qute://help/img/cheatsheet-big.png";
          yt = "https://inv.nadeko.net/";
          tmail = "https://mail.tutanota.com/";
        };
        keyBindings = {
          normal = {
            ",m" = "hint links spawn mpv {hint-url}";
          };
        };
        settings = {
          colors.webpage = {
            darkmode.enabled = true;
            preferred_color_scheme = "dark";
          };
          content = {
            cookies.accept = "no-3rdparty";
            pdfjs = true;
          };
          editor.command = [
            "foot"
            "-e"
            "tmux"
            "new-session"
            "vim"
            "{file}"
          ];
          fileselect = {
            handler = "external";
            folder.command = filepicker;
            multiple_files.command = filepicker;
            single_file.command = filepicker;
          };
          scrolling.bar = "never";
          statusbar = {
            widgets = [
              "keypress"
              "search_match"
              "url"
              "scroll"
              "tabs"
              "progress"
            ];
          };
          tabs = {
            last_close = "startpage";
            show = "never";
          };
          url = {
            default_page = "qute://start";
            start_pages = "qute://start";
          };
          window.transparent = true;
        };
        extraConfig = ''
          c.statusbar.padding = { "bottom": 2, "left": 15, "right": 15, "top": 2 }
        '';
      };
      chromium = {
        enable = true;
        extensions = [
          "fdjamakpfbbddfjaooikfcpapjohcfmg"
        ];
      };
    };
  };
}
