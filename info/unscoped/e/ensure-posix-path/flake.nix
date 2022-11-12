{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/ensure-posix-path?_rev=9-18d043974dc7676a750cb734e1c9f89d";
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
    ident = "ensure-posix-path";
    ldir  = "info/unscoped/e/ensure-posix-path";
    inherit packument fetchInfo;
  } // latest';

}
