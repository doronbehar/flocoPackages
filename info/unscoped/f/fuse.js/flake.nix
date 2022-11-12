{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/fuse.js?_rev=177-0aa6b7e57fbc68914e122fa2a9505334";
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
    ident = "fuse.js";
    ldir  = "info/unscoped/f/fuse.js";
    inherit packument fetchInfo;
  } // latest';

}
