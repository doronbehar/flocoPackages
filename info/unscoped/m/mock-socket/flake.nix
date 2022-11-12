{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/mock-socket?_rev=83-61750a05a2eaed2ac27fbf6774a57a01";
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
    ident = "mock-socket";
    ldir  = "info/unscoped/m/mock-socket";
    inherit packument fetchInfo;
  } // latest';

}
