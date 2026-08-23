{
  flake.homeModules.mpv = {pkgs, ...}: {
    programs.mpv = {
      enable = true;
      package = (
        pkgs.mpv.override {
          mpv-unwrapped = pkgs.mpv-unwrapped.override {
            waylandSupport = true;
            vapoursynthSupport = true;
            ffmpeg = pkgs.ffmpeg-full;
          };
          youtubeSupport = true;
          scripts = with pkgs.mpvScripts; [
            mpris
            uosc
            sponsorblock
            youtube-upnext
          ];
        }
      );
      config = {
        ytdl-format = "bestvideo+bestaudio";
      };
    };
  };
}
