{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/jest-config?_rev=417-5d5ec23f319cc658d6ec5eb121b27868";
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
    ident = "jest-config";
    ldir  = "info/unscoped/j/jest-config";
    inherit packument fetchInfo;
  } // latest';

}
