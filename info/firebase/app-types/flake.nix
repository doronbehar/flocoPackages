{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@firebase/app-types?_rev=2526-bd60a7a8897837cd38dcd859c8583714";
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
    ident = "@firebase/app-types";
    ldir  = "info/firebase/app-types";
    inherit packument fetchInfo;
  } // latest';

}
