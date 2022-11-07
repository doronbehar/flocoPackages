{

  inputs.packument.url   = "https://registry.npmjs.org/wkx?rev=27-fba91073d99247c9663f18f87f3825e0";
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
    ident = "wkx";
    ldir  = "info/unscoped/w/wkx";
    inherit packument fetchInfo;
  } // latest';

}
