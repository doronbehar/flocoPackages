{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@aws-sdk%2futil-config-provider?_rev=20-cc17ddabee88f64cfe2171123e3a0dd7";
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
    ident = "@aws-sdk/util-config-provider";
    ldir  = "info/aws-sdk/util-config-provider";
    inherit packument fetchInfo;
  } // latest';

}
