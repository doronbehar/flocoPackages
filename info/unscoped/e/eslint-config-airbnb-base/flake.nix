{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/eslint-config-airbnb-base?_rev=122-74e8713dd5013e9b6ea9472ff264d2d9";
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
    ident = "eslint-config-airbnb-base";
    ldir  = "info/unscoped/e/eslint-config-airbnb-base";
    inherit packument fetchInfo;
  } // latest';

}
