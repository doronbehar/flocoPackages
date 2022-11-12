{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@firebase%2fcomponent?_rev=1727-8e6f05929568ae0e6a992374fb792135";
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
    ident = "@firebase/component";
    ldir  = "info/firebase/component";
    inherit packument fetchInfo;
  } // latest';

}
