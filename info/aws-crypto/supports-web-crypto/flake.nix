{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@aws-crypto%2fsupports-web-crypto?_rev=20-0f7a14680bdc886404ed21bd9f9bb77a";
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
    scope = "@aws-crypto";
    ident = "@aws-crypto/supports-web-crypto";
    ldir  = "info/aws-crypto/supports-web-crypto";
    inherit packument fetchInfo;
  } // latest';

}