{

  inputs.packument.url   = "https://registry.npmjs.org/kareem?rev=68-ea6e2513ddaf2c295e4aa93b1c60c099";
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
    ident = "kareem";
    ldir  = "info/unscoped/k/kareem";
    inherit packument fetchInfo;
  } // latest';

}
