{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/eslint-plugin-jest?_rev=334-88c116ce698bbf815df37d14a6cf0904";
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
    ident = "eslint-plugin-jest";
    ldir  = "info/unscoped/e/eslint-plugin-jest";
    inherit packument fetchInfo;
  } // latest';

}
