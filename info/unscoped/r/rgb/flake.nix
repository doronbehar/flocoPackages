{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/rgb?_rev=10-e0106c52c86988e1e40d8a836395c6f6";
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
    ident = "rgb";
    ldir  = "info/unscoped/r/rgb";
    inherit packument fetchInfo;
  } // latest';

}
