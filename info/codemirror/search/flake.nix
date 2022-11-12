{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@codemirror/search?_rev=26-09e232a80a65cadf941549c77530b56c";
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
    ident = "@codemirror/search";
    ldir  = "info/codemirror/search";
    inherit packument fetchInfo;
  } // latest';

}
