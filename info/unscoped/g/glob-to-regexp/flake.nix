{

  inputs.packument.url   = "https://registry.npmjs.org/glob-to-regexp?rev=21-89df3edd1a9bcf5bc59fc3c3810c1e88";
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
    ident = "glob-to-regexp";
    ldir  = "info/unscoped/g/glob-to-regexp";
    inherit packument fetchInfo;
  } // latest';

}
