with { pkgs = import ./nix {}; };
let
  bashrc = pkgs.callPackage ./bashrc {};

  git = import ./git ({
    inherit (pkgs) makeWrapper symlinkJoin writeTextFile;
    git = pkgs.git;
  });

  python = pkgs.python.withPackages (ps: [ ps.grip ]);

  tmux = import ./tmux (with pkgs; {
    inherit makeWrapper symlinkJoin writeText;
    tmux = pkgs.tmux;
  });

  vim = pkgs.callPackage ./vim { inherit git tmux; };
in
{
  bashrc = bashrc;
  git = git;
  python = python;
  tmux = tmux;
  vim = vim;
}
