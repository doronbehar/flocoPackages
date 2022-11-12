{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@babel%2fplugin-transform-react-jsx?_rev=100-d73a5a248910b389b4921516f954f9e2";
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
    ident = "@babel/plugin-transform-react-jsx";
    ldir  = "info/babel/plugin-transform-react-jsx";
    inherit packument fetchInfo;
  } // latest';

}
