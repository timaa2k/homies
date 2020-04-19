{ git, symlinkJoin, makeWrapper, writeTextFile }:
with
  { gitHome = writeTextFile
      { name = "git-config";
        text =
          builtins.replaceStrings
          ["SUBSTITUTE_GITIGNORE"] ["${./gitignore}"]
          (builtins.readFile ./config);
        destination = "/git/config";
      };
  };

symlinkJoin {
  name = "git";
  buildInputs = [makeWrapper];
  paths = [ git ];
  postBuild = ''
    wrapProgram "$out/bin/git" \
    --set XDG_CONFIG_HOME "${gitHome}"
  '';
}
