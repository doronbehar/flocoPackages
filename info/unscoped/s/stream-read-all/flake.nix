{

  inputs.packument.url   = "https://registry.npmjs.org/stream-read-all?rev=8-921f3a4635bd75aaa8e0023eb0139191";
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
    ident = "stream-read-all";
    ldir  = "info/unscoped/s/stream-read-all";
    inherit packument fetchInfo;
  } // latest';

}
