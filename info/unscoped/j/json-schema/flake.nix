{

  inputs.packument.url   = "https://registry.npmjs.org/json-schema?rev=26-6e174cac846e644938fdcc401705fee2";
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
    ident = "json-schema";
    ldir  = "info/unscoped/j/json-schema";
    inherit packument fetchInfo;
  } // latest';

}
