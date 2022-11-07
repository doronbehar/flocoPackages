{

  inputs.packument.url   = "https://registry.npmjs.org/@jimp/plugins?rev=135-e051c11313ea02bc2d546c1cef808355";
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
    scope = "@jimp";
    ident = "@jimp/plugins";
    ldir  = "info/jimp/plugins";
    inherit packument fetchInfo;
  } // latest';

}
