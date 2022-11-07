{

  inputs.packument.url   = "https://registry.npmjs.org/websocket-driver?rev=54-1d08f70881ff9533a6f00cbed20dc7e9";
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
    ident = "websocket-driver";
    ldir  = "info/unscoped/w/websocket-driver";
    inherit packument fetchInfo;
  } // latest';

}
