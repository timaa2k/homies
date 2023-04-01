let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs {
    config = {};
    overlays = [
      (self: super: {
        sources = sources;
        bash-configured = super.callPackage ./bash { nixpkgs = sources.nixpkgs; };
        git-configured = super.callPackage ./git {};
        neovim-configured = super.callPackage ./neovim {};
        tmux-configured = super.callPackage ./tmux {};
      })
    ];
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
    nodejs
    ps
    python3
    python3Packages.pynvim
    ripgrep
    tree
    tmux-configured
    tmuxp
    utillinux
    xclip
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
