{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/ajv-draft-04?_rev=3-1421b852a20d46acbce170cc6b58d0c7";
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
    ident = "ajv-draft-04";
    ldir  = "info/unscoped/a/ajv-draft-04";
    inherit packument fetchInfo;
  } // latest';

}
