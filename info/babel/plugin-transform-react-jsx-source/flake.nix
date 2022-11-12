{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@babel/plugin-transform-react-jsx-source?_rev=84-431e3b5f4acc50bd5b3a93b01c94b816";
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
    ident = "@babel/plugin-transform-react-jsx-source";
    ldir  = "info/babel/plugin-transform-react-jsx-source";
    inherit packument fetchInfo;
  } // latest';

}
