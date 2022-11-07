{

  inputs.packument.url   = "https://registry.npmjs.org/is-property?rev=12-3535dea4a9298a2704e00d76b66c3979";
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
    ident = "is-property";
    ldir  = "info/unscoped/i/is-property";
    inherit packument fetchInfo;
  } // latest';

}
