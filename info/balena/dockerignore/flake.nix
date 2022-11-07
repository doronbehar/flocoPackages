{

  inputs.packument.url   = "https://registry.npmjs.org/@balena/dockerignore?rev=119-68f0c0095e54ec21063f7cec7d51783c";
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
    scope = "@balena";
    ident = "@balena/dockerignore";
    ldir  = "info/balena/dockerignore";
    inherit packument fetchInfo;
  } // latest';

}
