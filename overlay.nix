self: super:
let
  sources = import ./nix/sources.nix;
in
{
  sources = sources;
  bash-configured = super.callPackage ./bash { nixpkgs = sources.nixpkgs; };
  git-configured = super.callPackage ./git {};
  neovim-configured = super.callPackage ./neovim {};
  tmux-configured = super.callPackage ./tmux {};
}
