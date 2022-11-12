{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/mississippi?_rev=40-6a6a9a86992e259d72bb2e13c4056db2";
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
    ident = "mississippi";
    ldir  = "info/unscoped/m/mississippi";
    inherit packument fetchInfo;
  } // latest';

}