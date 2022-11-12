{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@aws-sdk/middleware-signing?_rev=124-2c35d41265af56a38ec128c0c7028d80";
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
    scope = "@aws-sdk";
    ident = "@aws-sdk/middleware-signing";
    ldir  = "info/aws-sdk/middleware-signing";
    inherit packument fetchInfo;
  } // latest';

}
