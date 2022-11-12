{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@grpc%2fgrpc-js?_rev=122-9f9b1276d9142256de8dd45eb8094b96";
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
    scope = "@grpc";
    ident = "@grpc/grpc-js";
    ldir  = "info/grpc/grpc-js";
    inherit packument fetchInfo;
  } // latest';

}
