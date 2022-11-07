{

  inputs.packument.url   = "https://registry.npmjs.org/@jest/source-map?rev=53-05cde36b5b7829ded31298a62eb4af00";
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
    scope = "@jest";
    ident = "@jest/source-map";
    ldir  = "info/jest/source-map";
    inherit packument fetchInfo;
  } // latest';

}
