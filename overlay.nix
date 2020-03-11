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

  dot-git = super.callPackage ./git {};
  dot-neovim = super.callPackage ./neovim { sources = sources; };
  dot-bash = super.callPackage ./bash { sources = sources; };
in
{
  sources = sources;
  niv = niv;
  rustracerd = rustracerd;
  dot-git = dot-git;
  dot-neovim = dot-neovim;
  dot-bash = dot-bash;
}
