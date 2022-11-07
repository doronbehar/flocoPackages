{

  inputs.packument.url   = "https://registry.npmjs.org/file-sync-cmp?rev=7-65bf050878e63a1089c6519c6468f672";
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
    ident = "file-sync-cmp";
    ldir  = "info/unscoped/f/file-sync-cmp";
    inherit packument fetchInfo;
  } // latest';

}
