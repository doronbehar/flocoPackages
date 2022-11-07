{

  inputs.packument.url   = "https://registry.npmjs.org/batch-processor?rev=7-682ef12a737f7b4b441a606f82445273";
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
    ident = "batch-processor";
    ldir  = "info/unscoped/b/batch-processor";
    inherit packument fetchInfo;
  } // latest';

}
