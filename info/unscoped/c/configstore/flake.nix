{

  inputs.packument.url   = "https://registry.npmjs.org/configstore?rev=163-8a099a5cf33ed980e5019a62d1861e6b";
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
    ident = "configstore";
    ldir  = "info/unscoped/c/configstore";
    inherit packument fetchInfo;
  } // latest';

}
