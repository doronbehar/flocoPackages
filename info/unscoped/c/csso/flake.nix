{

  inputs.packument.url   = "https://registry.npmjs.org/csso?rev=166-9a651c6eecef50ad26cacf1650450d88";
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
    ident = "csso";
    ldir  = "info/unscoped/c/csso";
    inherit packument fetchInfo;
  } // latest';

}
