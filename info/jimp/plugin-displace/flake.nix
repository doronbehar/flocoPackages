{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@jimp/plugin-displace?_rev=129-2f319656bcb087398ce5d358eb43954f";
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
    ident = "@jimp/plugin-displace";
    ldir  = "info/jimp/plugin-displace";
    inherit packument fetchInfo;
  } // latest';

}
