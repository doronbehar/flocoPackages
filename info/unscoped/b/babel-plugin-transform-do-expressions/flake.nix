{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/babel-plugin-transform-do-expressions?_rev=63-7f480441ba6aaf2c0aaf87c900e8824a";
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
    ident = "babel-plugin-transform-do-expressions";
    ldir  = "info/unscoped/b/babel-plugin-transform-do-expressions";
    inherit packument fetchInfo;
  } // latest';

}
