{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/osenv?_rev=52-0c651d442bcf2ffab2a58f476580424e";
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
    ident = "osenv";
    ldir  = "info/unscoped/o/osenv";
    inherit packument fetchInfo;
  } // latest';

}
