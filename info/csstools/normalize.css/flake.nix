{

  inputs.packument.url   = "https://registry.npmjs.org/@csstools/normalize.css?rev=9-23a52da898631c037ea2907bb9fc7e45";
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
    scope = "@csstools";
    ident = "@csstools/normalize.css";
    ldir  = "info/csstools/normalize.css";
    inherit packument fetchInfo;
  } // latest';

}
