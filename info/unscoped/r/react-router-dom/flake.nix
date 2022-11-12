{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/react-router-dom?_rev=226-44cde0d9b2e58094c0773567436e53b6";
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
    ident = "react-router-dom";
    ldir  = "info/unscoped/r/react-router-dom";
    inherit packument fetchInfo;
  } // latest';

}
