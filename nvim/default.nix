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
        papercolor-theme

        # IDE
        vim-sensible
        nerdtree
        fugitive
        vim-gitgutter
        vim-commentary
        vim-tmux-navigator
        vim-trailing-whitespace
        denite
        coc-nvim
        # FIXME(tim): Coc plugins are currently not in compiled form.
        # The workaround is to install them manually via :CocInstall
        # https://github.com/neoclide/coc.nvim/issues/559#issuecomment-546155113
        #coc-pairs
        #coc-prettier
        #coc-go
        #coc-python
        #coc-json
        #coc-yaml

        # Utils
        surround

        # Language Specific Plugins
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
