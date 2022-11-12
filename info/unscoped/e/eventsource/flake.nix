{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/eventsource?_rev=76-908b550748820ca6ea0ab721fed9fecf";
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
    ident = "eventsource";
    ldir  = "info/unscoped/e/eventsource";
    inherit packument fetchInfo;
  } // latest';

}
