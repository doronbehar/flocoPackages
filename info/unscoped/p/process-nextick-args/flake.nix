{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/process-nextick-args?_rev=16-ec16db120748320a07e76e5ede14ae0d";
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
    ident = "process-nextick-args";
    ldir  = "info/unscoped/p/process-nextick-args";
    inherit packument fetchInfo;
  } // latest';

}
