{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/postcss-values-parser?_rev=48-888872a541b3e030fb79a572fcf22785";
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
    ident = "postcss-values-parser";
    ldir  = "info/unscoped/p/postcss-values-parser";
    inherit packument fetchInfo;
  } // latest';

}
