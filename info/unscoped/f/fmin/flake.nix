{

  inputs.packument.url   = "https://registry.npmjs.org/fmin?rev=4-d821370e62aa13535a78da7cc9226327";
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
    ident = "fmin";
    ldir  = "info/unscoped/f/fmin";
    inherit packument fetchInfo;
  } // latest';

}
