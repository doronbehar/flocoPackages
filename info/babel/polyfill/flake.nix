{

  inputs.packument.url   = "https://registry.npmjs.org/@babel/polyfill?rev=92-eb85fdd5a452884bf020ee05dfe177e0";
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
    scope = "@babel";
    ident = "@babel/polyfill";
    ldir  = "info/babel/polyfill";
    inherit packument fetchInfo;
  } // latest';

}
