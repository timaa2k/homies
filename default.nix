let
  sources = import ./nix/sources.nix;
  overlay = import ./overlay.nix;

  pkgs = import sources.nixpkgs {
    overlays = [ overlay ];
    config = {};
  };

  homies = with pkgs;
    [
      bashrc
      myGit
      #myNeovim
      python
      tmux
      #niv

      curl
      fzf
      gnupg
      htop
      jq
      less
      moreutils
      nix
      nix-diff
      pass
      tree
      xclip
    ];

in
  if pkgs.lib.inNixShell
  then pkgs.mkShell
    { buildInputs = homies;
      shellHook = ''
        $(bashrc)
        '';
    }
  else homies
