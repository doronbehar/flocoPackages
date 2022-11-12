{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@swc%2fcore?_rev=344-ebd5f046e88a85f868aa6c033d38507a";
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
    ident = "@swc/core";
    ldir  = "info/swc/core";
    inherit packument fetchInfo;
  } // latest';

}