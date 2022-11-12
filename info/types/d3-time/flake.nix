{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@types%2fd3-time?_rev=629-50b5b747bc4115a0673a9eec700991d6";
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
    scope = "@types";
    ident = "@types/d3-time";
    ldir  = "info/types/d3-time";
    inherit packument fetchInfo;
  } // latest';

}