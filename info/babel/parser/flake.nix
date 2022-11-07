{

  inputs.packument.url   = "https://registry.npmjs.org/@babel/parser?rev=166-b6b30221db879d5bc5098df085821f02";
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
    ident = "@babel/parser";
    ldir  = "info/babel/parser";
    inherit packument fetchInfo;
  } // latest';

}
