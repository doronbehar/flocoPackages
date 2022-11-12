{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/react-resize-detector?_rev=111-495e6e7e94e4493a7b44f00c0e4bfed3";
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
    ident = "react-resize-detector";
    ldir  = "info/unscoped/r/react-resize-detector";
    inherit packument fetchInfo;
  } // latest';

}
