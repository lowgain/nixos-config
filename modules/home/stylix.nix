{
  self,
  inputs,
  ...
}: {
  flake.homeModules.stylix = {
    imports = [
      inputs.stylix.homeModules.stylix
    ];
  };
}
