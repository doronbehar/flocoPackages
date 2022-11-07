{

  inputs.packument.url   = "https://registry.npmjs.org/resolve-alpn?rev=7-390c0bed5cf90180878dab303fe0871d";
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
    ident = "resolve-alpn";
    ldir  = "info/unscoped/r/resolve-alpn";
    inherit packument fetchInfo;
  } // latest';

}
