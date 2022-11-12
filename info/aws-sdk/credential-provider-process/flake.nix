{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@aws-sdk%2fcredential-provider-process?_rev=120-1588be0ea8ad14510d3d3bd0549656a8";
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
    ident = "@aws-sdk/credential-provider-process";
    ldir  = "info/aws-sdk/credential-provider-process";
    inherit packument fetchInfo;
  } // latest';

}