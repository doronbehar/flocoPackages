{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/arr-diff?_rev=26-2f42c504b2f2cae5cd80ec2aabad0686";
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
    scope = null;
    ident = "arr-diff";
    ldir  = "info/unscoped/a/arr-diff";
    inherit packument fetchInfo;
  } // latest';

}