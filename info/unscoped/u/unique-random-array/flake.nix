{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/unique-random-array?_rev=13-856bb39f74d7827154df42d0d3866f6b";
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
    ident = "unique-random-array";
    ldir  = "info/unscoped/u/unique-random-array";
    inherit packument fetchInfo;
  } // latest';

}
