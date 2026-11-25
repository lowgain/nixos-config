{
  lib,
  pkgs,
}:

pkgs.python314Packages.buildPythonApplication (finalAttrs: {
  pname = "kolibri";
  version = "0.19.5";
  pyproject = true;

  src = builtins.fetchTarball {
    url = "https://github.com/learningequality/kolibri/releases/download/v${finalAttrs.version}/kolibri-${finalAttrs.version}.tar.gz";
    sha256 = "sha256-dWMvIhGVuSHqw7x4T8RBXDY3SkS/GDysSC/zaZPX52Y=";
  };

  build-system = with pkgs.python314Packages; [ setuptools ];

  meta = {
    homepage = "https://learningequality.org/kolibri/about-kolibri/";
    description = "Kolibri is a ecosystem of tools centered around offline learning.";
    mainProgram = "kolibri";
    changelog = "https://github.com/learningequality/kolibri/releases/tag/v${finalAttrs.version}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ lowgain ];
  };
})
