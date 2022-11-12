{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/cssnano-utils?_rev=30-dd4960c6767cb94cd68ca26197f368a2";
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
    ident = "cssnano-utils";
    ldir  = "info/unscoped/c/cssnano-utils";
    inherit packument fetchInfo;
  } // latest';

}
