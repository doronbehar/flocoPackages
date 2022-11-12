{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/get-stdin?_rev=34-28a797733b5c02e2a3c4140e6e8318e1";
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
    ident = "get-stdin";
    ldir  = "info/unscoped/g/get-stdin";
    inherit packument fetchInfo;
  } // latest';

}
