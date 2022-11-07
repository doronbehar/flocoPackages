{

  inputs.packument.url   = "https://registry.npmjs.org/isexe?rev=8-4ce12fb750602a4cff3c382405c68e22";
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
    ident = "isexe";
    ldir  = "info/unscoped/i/isexe";
    inherit packument fetchInfo;
  } // latest';

}
