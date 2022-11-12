{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/urllib?_rev=282-431d1a1357800da0f844bb1785b88cdc";
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
    ident = "urllib";
    ldir  = "info/unscoped/u/urllib";
    inherit packument fetchInfo;
  } // latest';

}
