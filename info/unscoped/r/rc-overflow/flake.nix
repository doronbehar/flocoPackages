{

  inputs.packument.url   = "https://registry.npmjs.org/rc-overflow?rev=36-3f2c1314522c5461df1700389ef2a872";
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
    ident = "rc-overflow";
    ldir  = "info/unscoped/r/rc-overflow";
    inherit packument fetchInfo;
  } // latest';

}
