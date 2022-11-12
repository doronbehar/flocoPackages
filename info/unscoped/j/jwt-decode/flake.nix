{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/jwt-decode?_rev=108-f4f092605c90b4ff55966d217cf97ca8";
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
    scope = null;
    ident = "jwt-decode";
    ldir  = "info/unscoped/j/jwt-decode";
    inherit packument fetchInfo;
  } // latest';

}
