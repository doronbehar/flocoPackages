{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/koa?_rev=521-bc18c75b6cabbe889be43713278b67ab";
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
    ident = "koa";
    ldir  = "info/unscoped/k/koa";
    inherit packument fetchInfo;
  } // latest';

}
