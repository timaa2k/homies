self: super:

let
  sources = import ./nix/sources.nix;

  myGit = import ./git {
    inherit (super) makeWrapper writeTextFile;
    symlinkJoin = self.symlinkJoin;
    git = super.git;
  };

  bashrc = import ./bashrc {
    inherit (super) writeText writeScriptBin;
    lib = self.lib;
    cacert = self.cacert;
    fzf = self.fzf;
    sources = sources;
  };
in
{
  sources = sources;
  myGit = myGit;
  bashrc = bashrc;
}
