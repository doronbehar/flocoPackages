{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/react-apollo?_rev=289-df4ae942526a657cfe710d9acbc4a673";
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
    ident = "react-apollo";
    ldir  = "info/unscoped/r/react-apollo";
    inherit packument fetchInfo;
  } // latest';

}
