{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/sw-precache-webpack-plugin?_rev=61-9dc55265213066ef6119666d96d1c14b";
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
    ident = "sw-precache-webpack-plugin";
    ldir  = "info/unscoped/s/sw-precache-webpack-plugin";
    inherit packument fetchInfo;
  } // latest';

}
