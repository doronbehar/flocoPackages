{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@svgr/babel-plugin-transform-react-native-svg?_rev=11-081c9b3b5f9aad8ebcbe2370e27cdd34";
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
    scope = "@svgr";
    ident = "@svgr/babel-plugin-transform-react-native-svg";
    ldir  = "info/svgr/babel-plugin-transform-react-native-svg";
    inherit packument fetchInfo;
  } // latest';

}
