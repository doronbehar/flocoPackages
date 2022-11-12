{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@aws-sdk/shared-ini-file-loader?_rev=94-25dc612393077018be8d6e69e27b3071";
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
    ident = "@aws-sdk/shared-ini-file-loader";
    ldir  = "info/aws-sdk/shared-ini-file-loader";
    inherit packument fetchInfo;
  } // latest';

}
