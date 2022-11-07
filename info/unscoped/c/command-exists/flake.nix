{

  inputs.packument.url   = "https://registry.npmjs.org/command-exists?rev=27-eb26943c48699c17b302c2c0f592cd49";
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
    ident = "command-exists";
    ldir  = "info/unscoped/c/command-exists";
    inherit packument fetchInfo;
  } // latest';

}
