with { pkgs = import ./nix {}; };
let
  python = pkgs.python.withPackages (ps: [ ps.grip ]);

  bashrc = pkgs.callPackage ./bashrc {};

  git = import ./git (
    { inherit (pkgs) makeWrapper symlinkJoin writeTextFile;
      git = pkgs.git;
    });

  tmux = import ./tmux (with pkgs;
    { inherit
        makeWrapper
        symlinkJoin
        writeText
        ;
      tmux = pkgs.tmux;
    });

  naersk = pkgs.callPackage pkgs.sources.naersk {};

  rusty-tags = naersk.buildPackage pkgs.sources.rusty-tags;
  nixpkgs-fmt = naersk.buildPackage pkgs.sources.nixpkgs-fmt;

  vim = pkgs.callPackage ./vim
    { inherit
        git
        tmux
        rusty-tags;
    };
in
{
  bashrc = bashrc;
  git = git;
  nixpkgs-fmt = nixpkgs-fmt;
  python = python;
  tmux = tmux;
  vim = vim;
}
