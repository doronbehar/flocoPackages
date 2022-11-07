{

  inputs.packument.url   = "https://registry.npmjs.org/babel-plugin-transform-react-jsx?rev=106-a01c9d08a18fbd4fc163da54add84410";
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
    ident = "babel-plugin-transform-react-jsx";
    ldir  = "info/unscoped/b/babel-plugin-transform-react-jsx";
    inherit packument fetchInfo;
  } // latest';

}
