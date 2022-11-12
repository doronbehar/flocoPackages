{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/streamsearch?_rev=24-6b361c8de7694a0f405f15c3830feeee";
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
    ident = "streamsearch";
    ldir  = "info/unscoped/s/streamsearch";
    inherit packument fetchInfo;
  } // latest';

}
