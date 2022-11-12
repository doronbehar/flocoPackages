{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/git-sha1?_rev=10-acfc47e9f8741b4fc1281846fce8c0a0";
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
    ident = "git-sha1";
    ldir  = "info/unscoped/g/git-sha1";
    inherit packument fetchInfo;
  } // latest';

}
