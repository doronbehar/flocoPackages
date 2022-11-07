{

  inputs.packument.url   = "https://registry.npmjs.org/workbox-window?rev=62-e73ace073b7fa6f3c184d9c02fe02131";
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
    ident = "workbox-window";
    ldir  = "info/unscoped/w/workbox-window";
    inherit packument fetchInfo;
  } // latest';

}
