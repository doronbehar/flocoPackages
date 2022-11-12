{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/lodash.clone?_rev=53-ae5fbc8c66f00b95a7f8bcdad47db98a";
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
    ident = "lodash.clone";
    ldir  = "info/unscoped/l/lodash.clone";
    inherit packument fetchInfo;
  } // latest';

}
