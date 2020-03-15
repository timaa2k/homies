self: super:

let
  sources = import ./nix/sources.nix;

  niv = self.haskell.lib.justStaticExecutables (import sources.niv {}).niv;

  # This is used by ycmd -> youcompleteme -> neovim and the fix wasn't
  # backported to 19.09
  rustracerd = super.rustracerd.overrideAttrs (oa: {
      nativeBuildInputs = (oa.nativeBuildInputs or []) ++ [ self.makeWrapper ];
      buildInputs = (oa.buildInputs or []) ++ self.stdenv.lib.optional self.stdenv.isDarwin self.darwin.Security;
  });

  dot-bash = super.callPackage ./bash { sources = sources; };
  dot-git = super.callPackage ./git {};
  dot-lf = super.callPackage ./lf {};
  dot-neovim = super.callPackage ./nvim { sources = sources; };
  dot-tmux = super.callPackage ./tmux {};
in
{
  sources = sources;
  niv = niv;
  rustracerd = rustracerd;
  dot-bash = dot-bash;
  dot-git = dot-git;
  dot-lf = dot-lf;
  dot-neovim = dot-neovim;
  dot-tmux = dot-tmux;
}
