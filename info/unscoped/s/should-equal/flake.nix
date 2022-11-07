{

  inputs.packument.url   = "https://registry.npmjs.org/should-equal?rev=45-81ac5ea120398dcd2a3c378393a9fb40";
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
    ident = "should-equal";
    ldir  = "info/unscoped/s/should-equal";
    inherit packument fetchInfo;
  } // latest';

}
