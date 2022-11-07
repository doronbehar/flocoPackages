{

  inputs.packument.url   = "https://registry.npmjs.org/@oclif/core?rev=143-c483d8203271f86da9ceb383a2313b57";
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
    scope = "@oclif";
    ident = "@oclif/core";
    ldir  = "info/oclif/core";
    inherit packument fetchInfo;
  } // latest';

}
