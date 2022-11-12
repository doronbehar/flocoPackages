{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@firebase/firestore-compat?_rev=516-a884c859938d774ba31e3acab0d0792e";
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
    ident = "@firebase/firestore-compat";
    ldir  = "info/firebase/firestore-compat";
    inherit packument fetchInfo;
  } // latest';

}
