{

  inputs.packument.url   = "https://registry.npmjs.org/metro-symbolicate?rev=47-6edf3216482e63d55f3533feb97cc2bb";
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
    ident = "metro-symbolicate";
    ldir  = "info/unscoped/m/metro-symbolicate";
    inherit packument fetchInfo;
  } // latest';

}
