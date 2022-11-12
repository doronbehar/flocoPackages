{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@swc%2fcore-win32-arm64-msvc?_rev=182-3ce9b101d09828c218508c3a30f03103";
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
    scope = "@swc";
    ident = "@swc/core-win32-arm64-msvc";
    ldir  = "info/swc/core-win32-arm64-msvc";
    inherit packument fetchInfo;
  } // latest';

}