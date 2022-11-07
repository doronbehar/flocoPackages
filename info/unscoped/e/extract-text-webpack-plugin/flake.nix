{

  inputs.packument.url   = "https://registry.npmjs.org/extract-text-webpack-plugin?rev=227-289f1169d9e1c21f349db50a2833021d";
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
    ident = "extract-text-webpack-plugin";
    ldir  = "info/unscoped/e/extract-text-webpack-plugin";
    inherit packument fetchInfo;
  } // latest';

}
