{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@babel/runtime-corejs2?_rev=111-4cbf730e71de0507670fc8008c261f67";
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
    scope = "@babel";
    ident = "@babel/runtime-corejs2";
    ldir  = "info/babel/runtime-corejs2";
    inherit packument fetchInfo;
  } // latest';

}
