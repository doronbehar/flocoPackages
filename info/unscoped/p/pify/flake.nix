{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/pify?_rev=83-4047511547952b3f461fe343077ec0f1";
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
    ident = "pify";
    ldir  = "info/unscoped/p/pify";
    inherit packument fetchInfo;
  } // latest';

}
