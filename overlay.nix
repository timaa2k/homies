self: super:

let
  sources = import ./nix/sources.nix;

  neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (oldAttrs: {
    version = "master";
    src = builtins.fetchGit {
      url = https://github.com/neovim/neovim.git;
    };
    nativeBuildInputs = super.neovim-unwrapped.nativeBuildInputs ++ [ super.tree-sitter ];
  });

  dot-bash = super.callPackage ./bash { sources = sources; };
  dot-git = super.callPackage ./git {};
  dot-lf = super.callPackage ./lf {};
  dot-neovim = super.callPackage ./nvim { neovim-unwrapped = neovim-unwrapped; };
  dot-tmux = super.callPackage ./tmux {};
in
{
  sources = sources;
  dot-bash = dot-bash;
  dot-git = dot-git;
  dot-lf = dot-lf;
  dot-neovim = dot-neovim;
  dot-tmux = dot-tmux;
}
