{

  inputs.packument.url   = "https://registry.npmjs.org/@babel/runtime-corejs3?rev=93-2838ad1b4e71b81b19d3c3e32470ad11";
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
    ident = "@babel/runtime-corejs3";
    ldir  = "info/babel/runtime-corejs3";
    inherit packument fetchInfo;
  } // latest';

}
