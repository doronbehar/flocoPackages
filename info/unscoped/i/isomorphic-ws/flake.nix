{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/isomorphic-ws?_rev=12-20f4a618aace1343c92cc6f83f01adb3";
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
    ident = "isomorphic-ws";
    ldir  = "info/unscoped/i/isomorphic-ws";
    inherit packument fetchInfo;
  } // latest';

}