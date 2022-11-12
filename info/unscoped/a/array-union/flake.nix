{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/array-union?_rev=18-aeb2460324d26051645dfab3f0516c9b";
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
    ident = "array-union";
    ldir  = "info/unscoped/a/array-union";
    inherit packument fetchInfo;
  } // latest';

}
