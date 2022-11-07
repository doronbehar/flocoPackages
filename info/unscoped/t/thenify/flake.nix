{

  inputs.packument.url   = "https://registry.npmjs.org/thenify?rev=34-e93afc0436fd93e5f4b1f1b4b653d83a";
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
    ident = "thenify";
    ldir  = "info/unscoped/t/thenify";
    inherit packument fetchInfo;
  } // latest';

}
