{ sources
, git
, coreutils
, tmux
, symlinkJoin
, makeWrapper
, neovim
, vimPlugins
, vimUtils
, ctags
, python37
}:
let
  extraPackages = with vimPlugins; [
    ctrlp
    elm-vim
    fugitive
    nerdcommenter
    nerdtree
    surround
    syntastic
    #tmux-navigator
    vim-airline
    vim-colorschemes
    vim-easymotion
    vim-indent-guides
    vim-markdown
    vim-multiple-cursors
    vim-nix
    vim-toml
    vim-tmux-navigator
    vim-trailing-whitespace
    vimproc
    youcompleteme
    (vimUtils.buildVimPlugin
      { name = "vim-terraform";
        src = sources.vim-terraform;
        buildPhase = ":";
      }
    )
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
