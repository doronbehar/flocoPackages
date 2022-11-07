{

  inputs.packument.url   = "https://registry.npmjs.org/echarts?rev=181-a81452be4f9f32f2b21f83f4f9a6fc04";
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
    ident = "echarts";
    ldir  = "info/unscoped/e/echarts";
    inherit packument fetchInfo;
  } // latest';

}
