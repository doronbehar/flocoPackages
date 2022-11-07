{

  inputs.packument.url   = "https://registry.npmjs.org/mqtt-packet?rev=92-72901e04fc8aa928e18cd10269d61b49";
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
    ident = "mqtt-packet";
    ldir  = "info/unscoped/m/mqtt-packet";
    inherit packument fetchInfo;
  } // latest';

}
