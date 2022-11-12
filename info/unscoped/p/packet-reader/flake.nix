{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/packet-reader?_rev=14-cccd6cb7c24685a571557741cb254fca";
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
    ident = "packet-reader";
    ldir  = "info/unscoped/p/packet-reader";
    inherit packument fetchInfo;
  } // latest';

}
