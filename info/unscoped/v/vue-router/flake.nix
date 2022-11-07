{

  inputs.packument.url   = "https://registry.npmjs.org/vue-router?rev=241-446e609dccd5fd634a788da82d2757a6";
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
    ident = "vue-router";
    ldir  = "info/unscoped/v/vue-router";
    inherit packument fetchInfo;
  } // latest';

}
