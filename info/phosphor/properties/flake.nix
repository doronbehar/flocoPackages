{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@phosphor/properties?_rev=22-c33c0cc9cd1916bfb3acc90ba9066255";
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
    scope = "@phosphor";
    ident = "@phosphor/properties";
    ldir  = "info/phosphor/properties";
    inherit packument fetchInfo;
  } // latest';

}
