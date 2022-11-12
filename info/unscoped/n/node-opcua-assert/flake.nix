{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/node-opcua-assert?_rev=58-d4e01cd5d755c678e7707e19f463239f";
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
    ident = "node-opcua-assert";
    ldir  = "info/unscoped/n/node-opcua-assert";
    inherit packument fetchInfo;
  } // latest';

}