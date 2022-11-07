{

  inputs.packument.url   = "https://registry.npmjs.org/localtunnel?rev=155-0aaf506c73afc270aa80c8e73c3fe997";
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
    ident = "localtunnel";
    ldir  = "info/unscoped/l/localtunnel";
    inherit packument fetchInfo;
  } // latest';

}
