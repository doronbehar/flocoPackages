{

  inputs.packument.url   = "https://registry.npmjs.org/uri-path?rev=7-13e58db59d24b7f17db603625b0ddfbc";
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
    ident = "uri-path";
    ldir  = "info/unscoped/u/uri-path";
    inherit packument fetchInfo;
  } // latest';

}
