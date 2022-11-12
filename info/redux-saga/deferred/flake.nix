{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@redux-saga/deferred?_rev=14-43d34460b936e63968070b33d22c32e2";
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
    scope = "@redux-saga";
    ident = "@redux-saga/deferred";
    ldir  = "info/redux-saga/deferred";
    inherit packument fetchInfo;
  } // latest';

}
