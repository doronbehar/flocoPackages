{

  inputs.packument.url   = "https://registry.npmjs.org/source-map-js?rev=5-2ca6bd1378d690e645b3f65c896f0653";
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
    ident = "source-map-js";
    ldir  = "info/unscoped/s/source-map-js";
    inherit packument fetchInfo;
  } // latest';

}
