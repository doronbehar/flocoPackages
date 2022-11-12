{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/node-opcua-server-discovery?_rev=244-e6e8b4d080c8ec1bc12564ad303b8e78";
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
    ident = "node-opcua-server-discovery";
    ldir  = "info/unscoped/n/node-opcua-server-discovery";
    inherit packument fetchInfo;
  } // latest';

}
