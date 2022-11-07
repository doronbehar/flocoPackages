{

  inputs.packument.url   = "https://registry.npmjs.org/browserify-zlib?rev=21-5f0cdceddd70cb9562c1df01edad10ac";
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
    ident = "browserify-zlib";
    ldir  = "info/unscoped/b/browserify-zlib";
    inherit packument fetchInfo;
  } // latest';

}
