{

  inputs.packument.url   = "https://registry.npmjs.org/react-addons-css-transition-group?rev=126-07482fbc40c2d7e0f80f7fdb03a9c619";
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
    ident = "react-addons-css-transition-group";
    ldir  = "info/unscoped/r/react-addons-css-transition-group";
    inherit packument fetchInfo;
  } // latest';

}
