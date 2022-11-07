{

  inputs.packument.url   = "https://registry.npmjs.org/ajv-formats?rev=40-f50dbb45e2b30e675c25fdec9dfbe1fe";
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
    ident = "ajv-formats";
    ldir  = "info/unscoped/a/ajv-formats";
    inherit packument fetchInfo;
  } // latest';

}
