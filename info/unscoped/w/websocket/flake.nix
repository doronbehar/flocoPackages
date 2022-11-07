{

  inputs.packument.url   = "https://registry.npmjs.org/websocket?rev=187-e14ad7cb86973a35df32af6dea1a3809";
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
    ident = "websocket";
    ldir  = "info/unscoped/w/websocket";
    inherit packument fetchInfo;
  } // latest';

}
