{

  inputs.packument.url   = "https://registry.npmjs.org/postcss-minify-font-values?rev=47-6a7eac639740e3ba50ceb80c03db849c";
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
    ident = "postcss-minify-font-values";
    ldir  = "info/unscoped/p/postcss-minify-font-values";
    inherit packument fetchInfo;
  } // latest';

}
