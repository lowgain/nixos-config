let
  theme = {
    dark = "#282828";
    light = "#fbf1c7";
    gray = "#928374";
    red = "#cc241d";
    green = "#98971a";
    yellow = "#d79921";
    blue = "#458588";
    purple = "#b16286";
    aqua = "#689d6a";
    orange = "#d65d0e";
    brightRed = "#fb4934";
    brightGreen = "#b8bb26";
    brightYellow = "#fabd2f";
    brightBlue = "#83a598";
    brightPurple = "#d3869b";
    brightAqua = "#8ec07c";
    brightOrange = "#fe8019";
    darkRed = "#9d0006";
    darkGreen = "#79740e";
    darkYellow = "#b57614";
    darkBlue = "#076678";
    darkPurple = "#8f3f71";
    darkAqua = "#427b58";
    darkOrange = "#af3a03";
  };

  stripHash = str:
    if builtins.substring 0 1 str == "#"
    then builtins.substring 1 (builtins.stringLength str - 1) str
    else str;

  themeNoHash = builtins.mapAttrs (_: v: stripHash v) theme;
in {
  flake = {
    inherit theme themeNoHash;
  };
}
