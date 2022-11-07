{

  inputs.packument.url   = "https://registry.npmjs.org/proxy-agent?rev=38-912bdc23cf93fe81613e88491d2b9464";
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
    ident = "proxy-agent";
    ldir  = "info/unscoped/p/proxy-agent";
    inherit packument fetchInfo;
  } // latest';

}
