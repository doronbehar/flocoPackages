{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/lodash.union?_rev=47-635acc5c322b0c8ea907e734c5d154ef";
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
    ident = "lodash.union";
    ldir  = "info/unscoped/l/lodash.union";
    inherit packument fetchInfo;
  } // latest';

}
