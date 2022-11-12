{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@emotion/styled?_rev=103-51e2e5993faa6b139e386ba1dd77203f";
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
    scope = "@emotion";
    ident = "@emotion/styled";
    ldir  = "info/emotion/styled";
    inherit packument fetchInfo;
  } // latest';

}
