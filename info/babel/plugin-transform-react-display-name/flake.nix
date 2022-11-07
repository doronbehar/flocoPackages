{

  inputs.packument.url   = "https://registry.npmjs.org/@babel/plugin-transform-react-display-name?rev=83-30a09fe900888d1a0b769519987e7362";
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
    scope = "@babel";
    ident = "@babel/plugin-transform-react-display-name";
    ldir  = "info/babel/plugin-transform-react-display-name";
    inherit packument fetchInfo;
  } // latest';

}
