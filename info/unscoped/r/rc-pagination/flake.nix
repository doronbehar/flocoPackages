{

  inputs.packument.url   = "https://registry.npmjs.org/rc-pagination?rev=213-f7eacc3f96429b3cd4a0f29b635aee06";
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
    ident = "rc-pagination";
    ldir  = "info/unscoped/r/rc-pagination";
    inherit packument fetchInfo;
  } // latest';

}
