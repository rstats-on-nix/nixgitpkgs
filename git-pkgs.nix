{ pkgs, ... }:

{
  BPCells = pkgs.rPackages.buildRPackage {
    name = "BPCells";
    src = pkgs.fetchgit {
      url = "https://github.com/bnprks/BPCells";
      rev = "v0.3.0";
      sha256 = "sha256-UvFS7qxW55qgqpen77Zigw6dXsSyUyNnx+vup/JHR1c=";
    };
    postPatch = ''
      patchShebangs configure
    '';
    nativeBuildInputs = [ pkgs.hdf5.dev ];
    propagatedBuildInputs = builtins.attrValues {
      inherit (pkgs.rPackages) 
        magrittr
        Matrix
        Rcpp
        rlang
        vctrs
        stringr
        tibble
        dplyr
        tidyr
        ggplot2
        scales
        patchwork
        scattermore
        ggrepel
        RColorBrewer
        hexbin
        RcppEigen;
    };
  };
}
