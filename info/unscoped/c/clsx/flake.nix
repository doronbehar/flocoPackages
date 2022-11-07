{

  inputs.packument.url   = "https://registry.npmjs.org/clsx?rev=11-e714a0579b785b65443c91df64e3828b";
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
    ident = "clsx";
    ldir  = "info/unscoped/c/clsx";
    inherit packument fetchInfo;
  } // latest';

}
