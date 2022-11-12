{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/bs-snippet-injector?_rev=18-c4f2e7356705c6b41f4369e8358a3ceb";
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
    ident = "bs-snippet-injector";
    ldir  = "info/unscoped/b/bs-snippet-injector";
    inherit packument fetchInfo;
  } // latest';

}
