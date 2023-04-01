{ sources
, fetchFromGitHub
, vimPlugins
, vimUtils
, wrapNeovim
, neovim-unwrapped
}:
let
  vim-wintabs = vimUtils.buildVimPlugin {
    name = "vim-wintabs";
    src = fetchFromGitHub {
      owner = "zefei";
      repo = "vim-wintabs";
      rev = "6d18d62ae0f293a108afee8c514706027faefcf3";
      sha256 = "0n677r3snif7rq0z3l16ig9w9vb855ghf2p89n1l0z1s9y8619k0";
    };
  };
in
wrapNeovim neovim-unwrapped {
  vimAlias = true;
  viAlias = true;
  withNodeJs = true;
  configure.customRC = builtins.readFile ./vimrc;
  configure.packages.myVimPackages = with vimPlugins; {
    start = [
      vim-airline
      vim-airline-themes
      vim-colorschemes

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
      vim-css-color

      # Language Specific Plugins
      vim-nix
      vim-terraform
      vim-toml
    ];
    opt = [
      vim-wintabs
    ];
  };
}
