{

  inputs.packument.url   = "https://registry.npmjs.org/cssnano?rev=203-aae93b963abd580196a1b245e5d2f527";
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
    ident = "cssnano";
    ldir  = "info/unscoped/c/cssnano";
    inherit packument fetchInfo;
  } // latest';

}
