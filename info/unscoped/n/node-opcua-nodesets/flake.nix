{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/node-opcua-nodesets?_rev=67-bbcb242b35f3149f1cd90228eaf2bbc4";
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
    ident = "node-opcua-nodesets";
    ldir  = "info/unscoped/n/node-opcua-nodesets";
    inherit packument fetchInfo;
  } // latest';

}