{

  inputs.packument.url   = "https://registry.npmjs.org/mssql?rev=422-6f3cd7f393cb480812549850b77e1fa2";
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
    ident = "mssql";
    ldir  = "info/unscoped/m/mssql";
    inherit packument fetchInfo;
  } // latest';

}
