{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/babel-plugin-transform-es2015-duplicate-keys?_rev=76-93bdcce63be8037bfcce03b1fedb3f24";
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
    ident = "babel-plugin-transform-es2015-duplicate-keys";
    ldir  = "info/unscoped/b/babel-plugin-transform-es2015-duplicate-keys";
    inherit packument fetchInfo;
  } // latest';

}
