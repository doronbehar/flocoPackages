{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@types/warning?_rev=439-0c604dd2be74981ada34b1b208c1329c";
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
    ident = "@types/warning";
    ldir  = "info/types/warning";
    inherit packument fetchInfo;
  } // latest';

}
