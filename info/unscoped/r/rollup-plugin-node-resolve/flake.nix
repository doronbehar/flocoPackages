{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/rollup-plugin-node-resolve?_rev=49-ac4e84f6d08e088077be432009887586";
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
    ident = "rollup-plugin-node-resolve";
    ldir  = "info/unscoped/r/rollup-plugin-node-resolve";
    inherit packument fetchInfo;
  } // latest';

}
