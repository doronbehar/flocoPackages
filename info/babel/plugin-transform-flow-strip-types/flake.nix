{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@babel%2fplugin-transform-flow-strip-types?_rev=90-c93c382c5a60b70ad5a5ce2e28379157";
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
    ident = "@babel/plugin-transform-flow-strip-types";
    ldir  = "info/babel/plugin-transform-flow-strip-types";
    inherit packument fetchInfo;
  } // latest';

}
