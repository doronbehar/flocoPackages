{

  inputs.packument.url   = "https://registry.npmjs.org/clean-stack?rev=24-d07669a45f1beb6d22195bd9d5b66070";
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
    ident = "clean-stack";
    ldir  = "info/unscoped/c/clean-stack";
    inherit packument fetchInfo;
  } // latest';

}
