{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/browser-sync?_rev=964-ee14a1a906fd7428c6e991259eacf7d4";
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
    ident = "browser-sync";
    ldir  = "info/unscoped/b/browser-sync";
    inherit packument fetchInfo;
  } // latest';

}
