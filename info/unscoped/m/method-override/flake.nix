{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/method-override?_rev=162-e227cf0f178285258a31b4a1ed4ec700";
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
    ident = "method-override";
    ldir  = "info/unscoped/m/method-override";
    inherit packument fetchInfo;
  } // latest';

}
