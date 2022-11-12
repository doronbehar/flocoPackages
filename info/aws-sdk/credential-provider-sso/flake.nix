{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@aws-sdk%2fcredential-provider-sso?_rev=118-05f892c029f7189ca74d2bcb484b2532";
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
    ident = "@aws-sdk/credential-provider-sso";
    ldir  = "info/aws-sdk/credential-provider-sso";
    inherit packument fetchInfo;
  } // latest';

}