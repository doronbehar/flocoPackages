{

  inputs.packument.url   = "https://registry.npmjs.org/strip-bom-string?rev=6-7df7b03aa1e3220030cb2776e5b4e58f";
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
    ident = "strip-bom-string";
    ldir  = "info/unscoped/s/strip-bom-string";
    inherit packument fetchInfo;
  } // latest';

}
