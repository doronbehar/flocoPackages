{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@csstools%2fpostcss-text-decoration-shorthand";
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
    scope = "@csstools";
    ident = "@csstools/postcss-text-decoration-shorthand";
    ldir  = "info/csstools/postcss-text-decoration-shorthand";
    inherit packument fetchInfo;
  } // latest';

}
