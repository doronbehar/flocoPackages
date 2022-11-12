{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@aws-sdk%2futil-middleware?_rev=24-7ab8138089e920c4d4ea6f61af73068d";
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
    ident = "@aws-sdk/util-middleware";
    ldir  = "info/aws-sdk/util-middleware";
    inherit packument fetchInfo;
  } // latest';

}