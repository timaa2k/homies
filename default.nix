let
  sources = import ./nix/sources.nix;
  overlay = import ./overlay.nix;

  pkgs = import sources.nixpkgs {
    overlays = [ overlay ];
    config = {};
  };

  homies = with pkgs;
    [
      dot-bash
      dot-git
      dot-tmux
      dot-neovim
      (python3.withPackages (p: with p; [
        pynvim
        python-language-server
        pyls-mypy
        pyls-isort
      ]))
      nodejs
      ripgrep

      niv
      python
      go
      godef
      gotools
      tmuxp

      curl
      fzf
      gnupg
      htop
      jq
      less
      moreutils
      nix
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
