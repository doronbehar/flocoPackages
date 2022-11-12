{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/postgres-range?_rev=8-1a37dd23157c6416ebd7ad46b6b35a12";
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
    ident = "postgres-range";
    ldir  = "info/unscoped/p/postgres-range";
    inherit packument fetchInfo;
  } // latest';

}
