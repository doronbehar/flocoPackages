{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/source-map-url?_rev=12-5aafcfe5f16fc0208431991e23679eea";
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
    ident = "source-map-url";
    ldir  = "info/unscoped/s/source-map-url";
    inherit packument fetchInfo;
  } // latest';

}