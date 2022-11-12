{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/cookiejar?_rev=55-9a39b5184bda52e63c2da721bde52d8c";
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
    ident = "cookiejar";
    ldir  = "info/unscoped/c/cookiejar";
    inherit packument fetchInfo;
  } // latest';

}
