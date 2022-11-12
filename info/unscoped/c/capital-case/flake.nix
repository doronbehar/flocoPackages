{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/capital-case?_rev=5-86b022d10a8c681b58501bf873f3a575";
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
    ident = "capital-case";
    ldir  = "info/unscoped/c/capital-case";
    inherit packument fetchInfo;
  } // latest';

}
