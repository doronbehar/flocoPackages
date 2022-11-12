{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/async-limiter?_rev=4-378e02638891472ae2ecc42863209d5c";
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
    ident = "async-limiter";
    ldir  = "info/unscoped/a/async-limiter";
    inherit packument fetchInfo;
  } // latest';

}