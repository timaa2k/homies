with { pkgs = import ./nix {}; };
let
  bashrc = pkgs.callPackage ./bashrc {};

  git = import ./git ({
    inherit (pkgs) makeWrapper symlinkJoin writeTextFile;
    git = pkgs.git;
  });

  neovim = pkgs.callPackage ./neovim { inherit git tmux; };

  python = pkgs.python.withPackages (ps: [
    ps.grip
  ]);

  tmux = import ./tmux (with pkgs; {
    inherit makeWrapper symlinkJoin writeText;
    tmux = pkgs.tmux;
  });
in
{
  bashrc = bashrc;
  git = git;
  neovim = neovim;
  python = python;
  tmux = tmux;
}
