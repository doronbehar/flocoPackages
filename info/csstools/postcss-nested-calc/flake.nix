{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@csstools/postcss-nested-calc";
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
    scope = "@csstools";
    ident = "@csstools/postcss-nested-calc";
    ldir  = "info/csstools/postcss-nested-calc";
    inherit packument fetchInfo;
  } // latest';

}
