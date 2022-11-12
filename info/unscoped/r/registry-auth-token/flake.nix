{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/registry-auth-token?_rev=31-ff511df2af172cd7f1ed796fcc636945";
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
    ident = "registry-auth-token";
    ldir  = "info/unscoped/r/registry-auth-token";
    inherit packument fetchInfo;
  } // latest';

}
