{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@types%2fd3-polygon?_rev=581-489dfcb95e1f8f317967aa54aa400a05";
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
    ident = "@types/d3-polygon";
    ldir  = "info/types/d3-polygon";
    inherit packument fetchInfo;
  } // latest';

}