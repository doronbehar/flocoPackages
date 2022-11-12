{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@types%2fcheerio?_rev=918-b786963d9ee2a77b2c9b28b151086acd";
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
    ident = "@types/cheerio";
    ldir  = "info/types/cheerio";
    inherit packument fetchInfo;
  } // latest';

}