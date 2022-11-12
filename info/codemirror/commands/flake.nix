{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@codemirror%2fcommands?_rev=25-34af92415ad13cecff0262140e68541f";
  inputs.packument.flake = false;

  outputs = inputs: let
    importJSON = f: builtins.fromJSON ( builtins.readFile f );
    packument  = importJSON inputs.packument;
    fetchInfo  = if ! builtins.pathExists ./fetchInfo.json then {} else
                 importJSON ./fetchInfo.json;
    latest'    = if ! ( packument ? dist-tags.latest ) then {} else {
      latestVersion = packument.dist-tags.latest;
      latest        = packument.versions.${packument.dist-tags.latest};
    };
  in {
    scope = "@codemirror";
    ident = "@codemirror/commands";
    ldir  = "info/codemirror/commands";
    inherit packument fetchInfo;
  } // latest';

}
