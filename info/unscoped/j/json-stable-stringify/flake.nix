{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/json-stable-stringify?_rev=46-d90a00565692aa5ccb7cff80ee734fa7";
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
    ident = "json-stable-stringify";
    ldir  = "info/unscoped/j/json-stable-stringify";
    inherit packument fetchInfo;
  } // latest';

}
