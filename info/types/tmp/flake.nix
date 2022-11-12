{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@types%2ftmp?_rev=539-195b6dcaee1507b439267142c4dca0a0";
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
    ident = "@types/tmp";
    ldir  = "info/types/tmp";
    inherit packument fetchInfo;
  } // latest';

}