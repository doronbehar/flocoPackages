{

  inputs.packument.url   = "https://registry.npmjs.org/lru-queue?rev=9-938fba5772206fc41aec5aa33b2dbae3";
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
    ident = "lru-queue";
    ldir  = "info/unscoped/l/lru-queue";
    inherit packument fetchInfo;
  } // latest';

}
