{

  inputs.packument.url   = "https://registry.npmjs.org/watchpack?rev=69-e4dd0fa1305672294c6191afaf2e72dc";
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
    ident = "watchpack";
    ldir  = "info/unscoped/w/watchpack";
    inherit packument fetchInfo;
  } // latest';

}
