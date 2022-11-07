{

  inputs.packument.url   = "https://registry.npmjs.org/es6-symbol?rev=27-17180f7d65ccbcb4e459cbc6cd837d1e";
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
    ident = "es6-symbol";
    ldir  = "info/unscoped/e/es6-symbol";
    inherit packument fetchInfo;
  } // latest';

}
