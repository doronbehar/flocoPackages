{

  inputs.packument.url   = "https://registry.npmjs.org/spdx-exceptions?rev=13-90955ed49c99ce03340e06376438bd07";
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
    ident = "spdx-exceptions";
    ldir  = "info/unscoped/s/spdx-exceptions";
    inherit packument fetchInfo;
  } // latest';

}
