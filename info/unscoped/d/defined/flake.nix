{

  inputs.packument.url   = "https://registry.npmjs.org/defined?rev=16-559415ebb4df744473886aa1cd0acbea";
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
    ident = "defined";
    ldir  = "info/unscoped/d/defined";
    inherit packument fetchInfo;
  } // latest';

}
