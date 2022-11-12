{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@aws-sdk%2futil-defaults-mode-browser?_rev=42-e4029edf7f1ddb21d73ecb8505c12102";
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
    ident = "@aws-sdk/util-defaults-mode-browser";
    ldir  = "info/aws-sdk/util-defaults-mode-browser";
    inherit packument fetchInfo;
  } // latest';

}
