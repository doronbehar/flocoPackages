{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/loader-runner?_rev=22-e3aac2b26393188f8542cc7e98498988";
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
    ident = "loader-runner";
    ldir  = "info/unscoped/l/loader-runner";
    inherit packument fetchInfo;
  } // latest';

}
