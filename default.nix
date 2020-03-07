with { pkgs = import ./nix {}; };
let
  custom = import ./packages.nix;

  homies = with pkgs;
    [
      custom.bashrc
      custom.git
      custom.python
      custom.tmux
      custom.neovim

      pkgs.curl
      pkgs.fzf
      pkgs.gnupg
      pkgs.htop
      pkgs.jq
      pkgs.less
      pkgs.moreutils
      pkgs.niv
      pkgs.nix
      pkgs.nix-diff
      pkgs.pass
      pkgs.tree
      pkgs.xclip
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
