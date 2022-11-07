{

  inputs.packument.url   = "https://registry.npmjs.org/jsdoc?rev=236-f89a3bcb04f8c79bd1c081f481f76b76";
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
    ident = "jsdoc";
    ldir  = "info/unscoped/j/jsdoc";
    inherit packument fetchInfo;
  } // latest';

}
