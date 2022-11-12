{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/static-extend?_rev=5-530bc79cd5fad97ca8959c56932c7fc6";
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
    ident = "static-extend";
    ldir  = "info/unscoped/s/static-extend";
    inherit packument fetchInfo;
  } // latest';

}