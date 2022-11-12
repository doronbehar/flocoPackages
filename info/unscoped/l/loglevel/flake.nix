{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/loglevel?_rev=71-f8a1426dcdbc37558abf3805bc088b39";
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
    ident = "loglevel";
    ldir  = "info/unscoped/l/loglevel";
    inherit packument fetchInfo;
  } // latest';

}
