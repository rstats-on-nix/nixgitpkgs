let
 pkgs = import (fetchTarball "https://github.com/rstats-on-nix/nixpkgs/archive/2025-04-11.tar.gz") { };

 githubPkgs = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/rstats-on-nix/github-pkgs/master/github-pkgs.nix";
    sha256 = "";
  };

  rPackages = pkgs.rPackages // githubPkgs;
 
  rpkgs = builtins.attrValues {
    inherit (rPackages) 
      BPCells
      dplyr;
  };

  system_packages = builtins.attrValues {
    inherit (pkgs) 
      glibcLocales
      nix
      R
      ;
  };
  
  shell = pkgs.mkShell {
    LOCALE_ARCHIVE = if pkgs.system == "x86_64-linux" then "${pkgs.glibcLocales}/lib/locale/locale-archive" else "";
    LANG = "en_US.UTF-8";
   LC_ALL = "en_US.UTF-8";
   LC_TIME = "en_US.UTF-8";
   LC_MONETARY = "en_US.UTF-8";
   LC_PAPER = "en_US.UTF-8";
   LC_MEASUREMENT = "en_US.UTF-8";

    buildInputs = [ rpkgs system_packages ];
    
  }; 
in
  {
    inherit pkgs shell;
  }