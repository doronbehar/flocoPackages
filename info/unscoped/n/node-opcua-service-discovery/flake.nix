{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/node-opcua-service-discovery?_rev=160-4dca4e2149eb397ac661fa211fd0b0e9";
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
    ident = "node-opcua-service-discovery";
    ldir  = "info/unscoped/n/node-opcua-service-discovery";
    inherit packument fetchInfo;
  } // latest';

}
