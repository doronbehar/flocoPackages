{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/esbuild-linux-arm64?_rev=314-cd9280a57fe45accebab0afe0d5f410b";
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
    ident = "esbuild-linux-arm64";
    ldir  = "info/unscoped/e/esbuild-linux-arm64";
    inherit packument fetchInfo;
  } // latest';

}