{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/is-path-cwd?_rev=13-4fc90148251a7be14f568b915eced575";
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
    ident = "is-path-cwd";
    ldir  = "info/unscoped/i/is-path-cwd";
    inherit packument fetchInfo;
  } // latest';

}
