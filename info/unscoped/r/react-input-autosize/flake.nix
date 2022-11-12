{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/react-input-autosize?_rev=65-682dc5caaaea0b8296c46e56a2a6cce4";
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
    ident = "react-input-autosize";
    ldir  = "info/unscoped/r/react-input-autosize";
    inherit packument fetchInfo;
  } // latest';

}