{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/babel-runtime?_rev=319-0127f62014fd342ed776eba96d69a106";
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
    ident = "babel-runtime";
    ldir  = "info/unscoped/b/babel-runtime";
    inherit packument fetchInfo;
  } // latest';

}
