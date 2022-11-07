{

  inputs.packument.url   = "https://registry.npmjs.org/envify?rev=81-1d48b795da57b00fc560ee570bf88272";
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
    ident = "envify";
    ldir  = "info/unscoped/e/envify";
    inherit packument fetchInfo;
  } // latest';

}
