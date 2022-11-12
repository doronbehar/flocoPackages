{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/to-arraybuffer?_rev=3-b1f2eb1070d2a56f85c634650af1191f";
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
    ident = "to-arraybuffer";
    ldir  = "info/unscoped/t/to-arraybuffer";
    inherit packument fetchInfo;
  } // latest';

}