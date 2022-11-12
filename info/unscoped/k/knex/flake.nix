{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/knex?_rev=536-62e299b28c37ac6736d1f9d5f55359b0";
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
    ident = "knex";
    ldir  = "info/unscoped/k/knex";
    inherit packument fetchInfo;
  } // latest';

}
