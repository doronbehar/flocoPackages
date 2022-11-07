{

  inputs.packument.url   = "https://registry.npmjs.org/teex?rev=2-d003c7794773f96a792acbf3e4fc276d";
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
    ident = "teex";
    ldir  = "info/unscoped/t/teex";
    inherit packument fetchInfo;
  } // latest';

}
