{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@babel/plugin-proposal-decorators?_rev=114-37df352bf76c50d44bf18543db2f7c99";
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
    ident = "@babel/plugin-proposal-decorators";
    ldir  = "info/babel/plugin-proposal-decorators";
    inherit packument fetchInfo;
  } // latest';

}
