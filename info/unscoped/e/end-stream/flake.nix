{

  inputs.packument.url   = "https://registry.npmjs.org/end-stream?rev=5-285a40270a0dd7bc1c6e3644bff16169";
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
    ident = "end-stream";
    ldir  = "info/unscoped/e/end-stream";
    inherit packument fetchInfo;
  } // latest';

}
