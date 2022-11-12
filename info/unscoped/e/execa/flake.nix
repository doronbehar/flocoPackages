{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/execa?_rev=95-b3bda88de4970f3f14b4590d8de46257";
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
    ident = "execa";
    ldir  = "info/unscoped/e/execa";
    inherit packument fetchInfo;
  } // latest';

}
