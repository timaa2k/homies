{ lf, symlinkJoin, makeWrapper, writeTextFile }:
with
  { configHome = writeTextFile
      { name = "lf-config";
        text = builtins.readFile ./lfrc;
        destination = "/lf/lfrc";
      };
  };

symlinkJoin {
  name = "lf";
  buildInputs = [makeWrapper];
  paths = [ lf ];
  postBuild = ''
    wrapProgram "$out/bin/lf" \
    --set XDG_CONFIG_HOME "${configHome}"
  '';
}
