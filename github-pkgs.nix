{ pkgs, ... }:

{
  BPCells = pkgs.rPackages.buildRPackage {
    name = "BPCells";
    src = pkgs.fetchgit {
      url = "https://github.com/bnprks/BPCells";
      rev = "0e23af2bc4de2acf9926da71ef1d241be9a35d90";
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
