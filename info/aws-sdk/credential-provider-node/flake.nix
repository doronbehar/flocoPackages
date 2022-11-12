{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@aws-sdk%2fcredential-provider-node?_rev=184-7ca4297fd0918ef3afb9a0ee6717f8e4";
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
    ident = "@aws-sdk/credential-provider-node";
    ldir  = "info/aws-sdk/credential-provider-node";
    inherit packument fetchInfo;
  } // latest';

}