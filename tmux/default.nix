{ lib, tmux, tmuxPlugins, symlinkJoin, makeWrapper, writeTextFile }:
let
  plugins = with tmuxPlugins; [
    continuum
    ctrlw
    fzf-tmux-url
    open
    sensible
    yank
  ];

  tmuxConf = writeTextFile {
    name = "tmux-conf";
    text = ( builtins.readFile ./tmux.conf ) + ''
      ${lib.concatStrings (map (x: "run-shell ${x.rtp}\n") plugins)}
    '';
  };
in
symlinkJoin {
  name = "tmux";
  buildInputs = [ makeWrapper ];
  paths = [ tmux ];
  postBuild = ''
    wrapProgram "$out/bin/tmux" \
    --add-flags "-f ${tmuxConf}"
  '';
}
