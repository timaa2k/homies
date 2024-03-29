let
  pkgs = import (import ./nix/sources.nix).nixpkgs {
    config = {};
    overlays = [ (import ./overlay.nix) ];
  };
  homies = with pkgs; [
    bash-completion
    bash-configured
    coreutils
    curl
    exa
    findutils
    fzf
    git-configured
    gnupg
    go
    gopls
    gotools
    htop
    jq
    less
    ncurses
    neovim-configured
    niv
    nix
    nix-prefetch-scripts
    nodejs
    ps
    python3
    python3Packages.pynvim
    ripgrep
    tree
    tmux-configured
    tmuxp
    unzip
    utillinux
    xclip
    youtube-dl
    yq
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
