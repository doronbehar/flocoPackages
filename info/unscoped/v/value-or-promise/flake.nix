{

  inputs.packument.url   = "https://registry.npmjs.org/value-or-promise?rev=13-1c93364f4c206c2b87e90866dab54363";
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
    ident = "value-or-promise";
    ldir  = "info/unscoped/v/value-or-promise";
    inherit packument fetchInfo;
  } // latest';

}
