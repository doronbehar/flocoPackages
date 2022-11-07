{

  inputs.packument.url   = "https://registry.npmjs.org/rcfinder?rev=24-ccde3a815a7fe727b8c46a51a2c86291";
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
    ident = "rcfinder";
    ldir  = "info/unscoped/r/rcfinder";
    inherit packument fetchInfo;
  } // latest';

}
