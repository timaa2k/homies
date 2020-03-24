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
      bash-completion
      exa
      dot-git
      dot-lf
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
      fzf
      fd
      bat
      ncurses

      niv
      python
      go
      godef
      gotools
      tmuxp

      coreutils
      curl
      findutils
      gnupg
      htop
      jq
      less
      moreutils
      nix
      pass
      tree
      utillinux
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
