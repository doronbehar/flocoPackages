{

  inputs.packument.url   = "https://registry.npmjs.org/koa-static?rev=93-0e967ae07a1aed8c05e2935028aeb380";
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
    ident = "koa-static";
    ldir  = "info/unscoped/k/koa-static";
    inherit packument fetchInfo;
  } // latest';

}
