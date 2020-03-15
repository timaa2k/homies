{ sources
, neovim
, vimPlugins
}:
neovim.override {
  vimAlias = true;
  viAlias = true;
  withPython = false;
  withPython3 = true;
  withRuby = false;
  configure.customRC = builtins.readFile ./vimrc;
  configure.packages.MyVimPackages = with vimPlugins; {
    start = [
      vim-airline
      vim-airline-themes
      vim-colorschemes
      papercolor-theme

      # IDE
      echodoc
      vim-sensible
      nerdtree
      nerdtree-git-plugin
      fugitive
      vim-gitgutter
      vim-commentary
      vim-tmux-navigator
      vim-trailing-whitespace
      #denite-nvim
      #denite-git
      fzf-vim
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
}
