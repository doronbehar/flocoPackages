{

  inputs.packument.url   = "https://registry.npmjs.org/read-cache?rev=3-d44c035816db3ffb5b917ba6aa3aacee";
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
    ident = "read-cache";
    ldir  = "info/unscoped/r/read-cache";
    inherit packument fetchInfo;
  } // latest';

}
