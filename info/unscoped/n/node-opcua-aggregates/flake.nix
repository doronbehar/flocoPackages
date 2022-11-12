{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/node-opcua-aggregates?_rev=160-de970ba080aad442b64b0ff6b0c20949";
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
    ident = "node-opcua-aggregates";
    ldir  = "info/unscoped/n/node-opcua-aggregates";
    inherit packument fetchInfo;
  } // latest';

}