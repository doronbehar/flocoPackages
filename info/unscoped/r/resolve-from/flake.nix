{

  inputs.packument.url   = "https://registry.npmjs.org/resolve-from?rev=18-59c5d17fb0816cddfd026c98fa2df2ad";
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
    ident = "resolve-from";
    ldir  = "info/unscoped/r/resolve-from";
    inherit packument fetchInfo;
  } // latest';

}
