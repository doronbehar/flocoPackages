{

  inputs.packument.url   = "https://registry.npmjs.org/postcss-modules-local-by-default?rev=42-576b6bb5701153715254ea4fce823c79";
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
    ident = "postcss-modules-local-by-default";
    ldir  = "info/unscoped/p/postcss-modules-local-by-default";
    inherit packument fetchInfo;
  } // latest';

}
