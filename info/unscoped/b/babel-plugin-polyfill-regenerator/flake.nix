{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/babel-plugin-polyfill-regenerator?_rev=25-c84a59661a02437481d41016a5ce904d";
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
    ident = "babel-plugin-polyfill-regenerator";
    ldir  = "info/unscoped/b/babel-plugin-polyfill-regenerator";
    inherit packument fetchInfo;
  } // latest';

}
