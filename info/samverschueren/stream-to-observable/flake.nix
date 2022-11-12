{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@samverschueren%2fstream-to-observable?_rev=2-c46c4c1f98cde271e9ab1403f4cf53ac";
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
    scope = "@samverschueren";
    ident = "@samverschueren/stream-to-observable";
    ldir  = "info/samverschueren/stream-to-observable";
    inherit packument fetchInfo;
  } // latest';

}
