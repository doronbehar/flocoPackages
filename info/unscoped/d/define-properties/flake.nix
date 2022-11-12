{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/define-properties?_rev=13-6db4ba34fbc79d05ca73caba755f5b35";
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
    ident = "define-properties";
    ldir  = "info/unscoped/d/define-properties";
    inherit packument fetchInfo;
  } // latest';

}
