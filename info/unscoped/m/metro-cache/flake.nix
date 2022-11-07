{

  inputs.packument.url   = "https://registry.npmjs.org/metro-cache?rev=106-2708e7915ed5c5ccc02339b231da6aff";
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
    ident = "metro-cache";
    ldir  = "info/unscoped/m/metro-cache";
    inherit packument fetchInfo;
  } // latest';

}
