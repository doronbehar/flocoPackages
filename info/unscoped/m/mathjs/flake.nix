{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/mathjs?_rev=402-31a457ccd67cfd07de27c536291227d2";
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
    ident = "mathjs";
    ldir  = "info/unscoped/m/mathjs";
    inherit packument fetchInfo;
  } // latest';

}
