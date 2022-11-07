{

  inputs.packument.url   = "https://registry.npmjs.org/github?rev=266-24f9cbc90af19acd132da69859a7a69e";
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
    ident = "github";
    ldir  = "info/unscoped/g/github";
    inherit packument fetchInfo;
  } // latest';

}
