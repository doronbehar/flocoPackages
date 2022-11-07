{

  inputs.packument.url   = "https://registry.npmjs.org/node-abi?rev=84-a79e53fc02a630fbcad90137d4cf50d6";
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
    ident = "node-abi";
    ldir  = "info/unscoped/n/node-abi";
    inherit packument fetchInfo;
  } // latest';

}
