{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@svgr%2fbabel-plugin-svg-dynamic-title?_rev=14-130dae0db140c8d65cdb57036a711a85";
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
    scope = "@svgr";
    ident = "@svgr/babel-plugin-svg-dynamic-title";
    ldir  = "info/svgr/babel-plugin-svg-dynamic-title";
    inherit packument fetchInfo;
  } // latest';

}
