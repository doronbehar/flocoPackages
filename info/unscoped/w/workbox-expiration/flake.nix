{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/workbox-expiration?_rev=59-a439ab57a233b1a626241dc474bd3608";
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
    ident = "workbox-expiration";
    ldir  = "info/unscoped/w/workbox-expiration";
    inherit packument fetchInfo;
  } // latest';

}
