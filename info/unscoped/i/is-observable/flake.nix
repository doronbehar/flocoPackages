{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/is-observable?_rev=10-cb316d6780ad605e6111b6effdc4e1b2";
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
    ident = "is-observable";
    ldir  = "info/unscoped/i/is-observable";
    inherit packument fetchInfo;
  } // latest';

}
