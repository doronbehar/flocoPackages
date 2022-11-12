{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@aws-sdk%2futil-user-agent-node?_rev=133-50ecd8c82658a1e7d899307801003b19";
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
    ident = "@aws-sdk/util-user-agent-node";
    ldir  = "info/aws-sdk/util-user-agent-node";
    inherit packument fetchInfo;
  } // latest';

}