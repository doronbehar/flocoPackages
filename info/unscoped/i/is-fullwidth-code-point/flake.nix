{

  inputs.packument.url   = "https://registry.npmjs.org/is-fullwidth-code-point?rev=11-9d2fbc42fcab7d07c8e177de29f11af7";
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
    ident = "is-fullwidth-code-point";
    ldir  = "info/unscoped/i/is-fullwidth-code-point";
    inherit packument fetchInfo;
  } // latest';

}
