{

  inputs.packument.url   = "https://registry.npmjs.org/svg-parser?rev=16-28aba962682bdba10ec99cc1ed0303f1";
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
    ident = "svg-parser";
    ldir  = "info/unscoped/s/svg-parser";
    inherit packument fetchInfo;
  } // latest';

}
