{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/pkginfo?_rev=43-c5ad13053ec76b453558569806e955ea";
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
    ident = "pkginfo";
    ldir  = "info/unscoped/p/pkginfo";
    inherit packument fetchInfo;
  } // latest';

}
