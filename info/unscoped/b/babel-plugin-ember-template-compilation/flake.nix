{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/babel-plugin-ember-template-compilation?_rev=12-612556cdff672de4aa272411c5898c73";
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
    ident = "babel-plugin-ember-template-compilation";
    ldir  = "info/unscoped/b/babel-plugin-ember-template-compilation";
    inherit packument fetchInfo;
  } // latest';

}
