{

  inputs.packument.url   = "https://registry.npmjs.org/babel-helper-hoist-variables?rev=80-9872986549e2bcf542ea7b614040df8b";
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
    ident = "babel-helper-hoist-variables";
    ldir  = "info/unscoped/b/babel-helper-hoist-variables";
    inherit packument fetchInfo;
  } // latest';

}
