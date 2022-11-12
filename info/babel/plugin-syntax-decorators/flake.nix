{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@babel/plugin-syntax-decorators?_rev=82-386dc0c22106cc16cd9cbe045663233d";
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
    ident = "@babel/plugin-syntax-decorators";
    ldir  = "info/babel/plugin-syntax-decorators";
    inherit packument fetchInfo;
  } // latest';

}
