{

  inputs.packument.url   = "https://registry.npmjs.org/os-tmpdir?rev=9-61d2547d5efae4aff2634f42063a2fa7";
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
    ident = "os-tmpdir";
    ldir  = "info/unscoped/o/os-tmpdir";
    inherit packument fetchInfo;
  } // latest';

}
