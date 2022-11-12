{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@lumino%2fvirtualdom?_rev=43-c4916c79cf98ede679ae62619113ef34";
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
    scope = "@lumino";
    ident = "@lumino/virtualdom";
    ldir  = "info/lumino/virtualdom";
    inherit packument fetchInfo;
  } // latest';

}
