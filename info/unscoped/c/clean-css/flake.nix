{

  inputs.packument.url   = "https://registry.npmjs.org/clean-css?rev=481-8250af53fb65bc7278a4fbcc5bbeefd7";
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
    ident = "clean-css";
    ldir  = "info/unscoped/c/clean-css";
    inherit packument fetchInfo;
  } // latest';

}
