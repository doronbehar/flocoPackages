{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@aws-sdk%2fcredential-provider-imds?_rev=124-efa0cc49f6a6dda527740876cb9120aa";
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
    ident = "@aws-sdk/credential-provider-imds";
    ldir  = "info/aws-sdk/credential-provider-imds";
    inherit packument fetchInfo;
  } // latest';

}