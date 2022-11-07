{

  inputs.packument.url   = "https://registry.npmjs.org/apollo-link-http-common?rev=24-04391ee434c9d9b7317efe000959ff53";
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
    ident = "apollo-link-http-common";
    ldir  = "info/unscoped/a/apollo-link-http-common";
    inherit packument fetchInfo;
  } // latest';

}
