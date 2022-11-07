{

  inputs.packument.url   = "https://registry.npmjs.org/ajv-keywords?rev=53-41b0a2bd594525961f07d9302932a8a8";
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
    ident = "ajv-keywords";
    ldir  = "info/unscoped/a/ajv-keywords";
    inherit packument fetchInfo;
  } // latest';

}
