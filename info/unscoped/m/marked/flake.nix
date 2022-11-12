{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/marked?_rev=474-3a017a854d90bcbc4127329d0c80704f";
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
    ident = "marked";
    ldir  = "info/unscoped/m/marked";
    inherit packument fetchInfo;
  } // latest';

}
