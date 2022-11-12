{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/libnpmpack?_rev=32-e5de495a40914d01396cadc4e61d23a3";
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
    ident = "libnpmpack";
    ldir  = "info/unscoped/l/libnpmpack";
    inherit packument fetchInfo;
  } // latest';

}
