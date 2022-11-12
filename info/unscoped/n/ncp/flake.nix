{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/ncp?_rev=155-866d26162afcf5b143f77df1d15f74e3";
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
    ident = "ncp";
    ldir  = "info/unscoped/n/ncp";
    inherit packument fetchInfo;
  } // latest';

}
