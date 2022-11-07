{

  inputs.packument.url   = "https://registry.npmjs.org/bounce?rev=25-9f86c8f0950e8f676f92d1cb03a9113b";
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
    ident = "bounce";
    ldir  = "info/unscoped/b/bounce";
    inherit packument fetchInfo;
  } // latest';

}
