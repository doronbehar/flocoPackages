{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@types%2fchai?_rev=1014-efeff692035bb505d09fe8195e762c02";
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
    ident = "@types/chai";
    ldir  = "info/types/chai";
    inherit packument fetchInfo;
  } // latest';

}