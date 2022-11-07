{

  inputs.packument.url   = "https://registry.npmjs.org/immutable?rev=327-882f87f29f1c40a86e0bb47cc8c0a54a";
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
    ident = "immutable";
    ldir  = "info/unscoped/i/immutable";
    inherit packument fetchInfo;
  } // latest';

}
