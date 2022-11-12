{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/urijs?_rev=58-be33b0c21c36f1226fc043f890242c8b";
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
    scope = null;
    ident = "urijs";
    ldir  = "info/unscoped/u/urijs";
    inherit packument fetchInfo;
  } // latest';

}
