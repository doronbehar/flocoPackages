{

  inputs.packument.url   = "https://registry.npmjs.org/sync-request?rev=47-0be790c2d93f85359c23ac826b8ac242";
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
    ident = "sync-request";
    ldir  = "info/unscoped/s/sync-request";
    inherit packument fetchInfo;
  } // latest';

}
