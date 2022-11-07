{

  inputs.packument.url   = "https://registry.npmjs.org/static-eval?rev=46-02b4b9fc1629e59e7e690b43b7b1568c";
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
    ident = "static-eval";
    ldir  = "info/unscoped/s/static-eval";
    inherit packument fetchInfo;
  } // latest';

}
