{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/is-accessor-descriptor?_rev=13-3bb80084268b0bda08aaa0f90dda00fd";
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
    ident = "is-accessor-descriptor";
    ldir  = "info/unscoped/i/is-accessor-descriptor";
    inherit packument fetchInfo;
  } // latest';

}