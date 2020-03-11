{ sources
, git
, coreutils
, tmux
, symlinkJoin
, makeWrapper
, neovim
, vimPlugins
, ctags
, python37
}:
let
  extraPackages = with vimPlugins; [
    #ctrlp
    fugitive
    nerdcommenter
    nerdtree
    surround
    syntastic
    vim-airline
    vim-colorschemes
    vim-easymotion
    vim-indent-guides
    vim-markdown
    vim-multiple-cursors
    vim-nix
    vim-terraform
    vim-tmux-navigator
    vim-toml
    vim-trailing-whitespace
    vimproc
    youcompleteme
  ];
  myNeovim = neovim.override {
    configure.customRC = builtins.readFile ./vimrc;
    configure.packages.myVimPackage = {
      start = extraPackages;
    };
  };
in
symlinkJoin {
  name = "neovim";
  buildInputs = [makeWrapper];
  postBuild = ''
    wrapProgram "$out/bin/nvim" \
      --set PATH '${python37}/bin:${coreutils}/bin:${ctags}/bin:${git}/bin:${tmux}/bin'
  '';
  paths = [ myNeovim ];
}
