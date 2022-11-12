{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/ioredis?_rev=348-551166ddee36382c66cb11c49a94b16d";
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
    ident = "ioredis";
    ldir  = "info/unscoped/i/ioredis";
    inherit packument fetchInfo;
  } // latest';

}
