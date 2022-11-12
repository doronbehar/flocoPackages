{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/babel-plugin-syntax-export-extensions?_rev=65-81bb0b381608d2b7b0b7e1d3c4084aa3";
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
    ident = "babel-plugin-syntax-export-extensions";
    ldir  = "info/unscoped/b/babel-plugin-syntax-export-extensions";
    inherit packument fetchInfo;
  } // latest';

}
