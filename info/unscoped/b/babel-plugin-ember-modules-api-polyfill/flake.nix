{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/babel-plugin-ember-modules-api-polyfill?_rev=46-b42b1cefe89b61099196971781133110";
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
    ident = "babel-plugin-ember-modules-api-polyfill";
    ldir  = "info/unscoped/b/babel-plugin-ember-modules-api-polyfill";
    inherit packument fetchInfo;
  } // latest';

}
