{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/should-type?_rev=21-12b770658e210b83dcaaf72ce216f64c";
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
    ident = "should-type";
    ldir  = "info/unscoped/s/should-type";
    inherit packument fetchInfo;
  } // latest';

}
