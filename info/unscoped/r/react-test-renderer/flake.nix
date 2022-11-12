{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/react-test-renderer?_rev=1292-dae6066ca4a605e659a864cc6eaeb77d";
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
    ident = "react-test-renderer";
    ldir  = "info/unscoped/r/react-test-renderer";
    inherit packument fetchInfo;
  } // latest';

}
