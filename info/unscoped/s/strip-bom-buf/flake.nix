{

  inputs.packument.url   = "https://registry.npmjs.org/strip-bom-buf?rev=7-dd76e7bd872f2132e39e7d2457efcff4";
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
    ident = "strip-bom-buf";
    ldir  = "info/unscoped/s/strip-bom-buf";
    inherit packument fetchInfo;
  } // latest';

}
