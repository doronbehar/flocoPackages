{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@ethersproject/properties?_rev=53-5f21aaf89778f71cee6e3645e0c7685e";
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
    scope = "@ethersproject";
    ident = "@ethersproject/properties";
    ldir  = "info/ethersproject/properties";
    inherit packument fetchInfo;
  } // latest';

}
