{

  inputs.packument.url   = "https://registry.npmjs.org/node-addon-api?rev=55-5de0eee4a528e666ac5799c5e47c060f";
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
    ident = "node-addon-api";
    ldir  = "info/unscoped/n/node-addon-api";
    inherit packument fetchInfo;
  } // latest';

}
