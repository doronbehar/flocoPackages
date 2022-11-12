{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@firebase%2fperformance-types?_rev=1955-96c9c71fa4d3cd41853b303dc5472ef0";
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
    scope = "@firebase";
    ident = "@firebase/performance-types";
    ldir  = "info/firebase/performance-types";
    inherit packument fetchInfo;
  } // latest';

}
