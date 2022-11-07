{

  inputs.packument.url   = "https://registry.npmjs.org/d3-chord?rev=26-9125de4cfead21571d2279f2c5c91a03";
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
    ident = "d3-chord";
    ldir  = "info/unscoped/d/d3-chord";
    inherit packument fetchInfo;
  } // latest';

}
