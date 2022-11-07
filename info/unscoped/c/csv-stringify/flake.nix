{

  inputs.packument.url   = "https://registry.npmjs.org/csv-stringify?rev=82-92479c702c06c38cd1224eed7d5ff473";
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
    ident = "csv-stringify";
    ldir  = "info/unscoped/c/csv-stringify";
    inherit packument fetchInfo;
  } // latest';

}
