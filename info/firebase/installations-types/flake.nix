{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@firebase/installations-types?_rev=1965-d5ce6c4f5bd6f84f7fb843ccfa6505c8";
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
    ident = "@firebase/installations-types";
    ldir  = "info/firebase/installations-types";
    inherit packument fetchInfo;
  } // latest';

}
