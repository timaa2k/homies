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
  myNeovim = neovim.override {
    vimAlias = true;
    viAlias = true;
    withPython = false;
    withPython3 = true;
    withRuby = false;
    configure.customRC = builtins.readFile ./vimrc;
    configure.packages.myVimPackage = {
      start = with vimPlugins; [
        # UI
        vim-airline
        vim-colorschemes

        # IDE
        #ctrlp
        nerdtree
        fugitive
        syntastic
        vim-tmux-navigator
        vim-trailing-whitespace
        #youcompleteme
        ncm2
        coc-nvim
        coc-go
        coc-json
        coc-python
        coc-yaml

        # Utils
        nerdcommenter
        surround

        # Language Specific Plugins
        LanguageClient-neovim
        vim-nix
        vim-terraform
        vim-toml
      ];
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
