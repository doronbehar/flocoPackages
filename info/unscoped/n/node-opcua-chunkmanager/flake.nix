{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/node-opcua-chunkmanager?_rev=153-ac10ed3f98fad47097d0639f78b81960";
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
    ident = "node-opcua-chunkmanager";
    ldir  = "info/unscoped/n/node-opcua-chunkmanager";
    inherit packument fetchInfo;
  } // latest';

}