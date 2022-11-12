{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@types/d3-hierarchy?_rev=674-c0218259ba0ff00e2d3da94b945c8c70";
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
    ident = "@types/d3-hierarchy";
    ldir  = "info/types/d3-hierarchy";
    inherit packument fetchInfo;
  } // latest';

}
