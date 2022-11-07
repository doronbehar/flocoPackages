{

  inputs.packument.url   = "https://registry.npmjs.org/babel-plugin-htmlbars-inline-precompile?rev=50-423fde099aa5bbab0e6cee9a4c40f85b";
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
    ident = "babel-plugin-htmlbars-inline-precompile";
    ldir  = "info/unscoped/b/babel-plugin-htmlbars-inline-precompile";
    inherit packument fetchInfo;
  } // latest';

}
