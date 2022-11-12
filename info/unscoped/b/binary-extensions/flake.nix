{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/binary-extensions?_rev=38-318e7d89f71bf0d289e97a0527f82a77";
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
    ident = "binary-extensions";
    ldir  = "info/unscoped/b/binary-extensions";
    inherit packument fetchInfo;
  } // latest';

}
