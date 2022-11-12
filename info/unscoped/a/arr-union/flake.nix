{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/arr-union?_rev=12-82b9a5aa7c86ec67928186b7cf32adb5";
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
    ident = "arr-union";
    ldir  = "info/unscoped/a/arr-union";
    inherit packument fetchInfo;
  } // latest';

}