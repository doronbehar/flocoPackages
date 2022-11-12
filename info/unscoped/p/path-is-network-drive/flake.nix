{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/path-is-network-drive?_rev=11-0bfb539f7c34fee7b0205f40f501c341";
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
    ident = "path-is-network-drive";
    ldir  = "info/unscoped/p/path-is-network-drive";
    inherit packument fetchInfo;
  } // latest';

}
