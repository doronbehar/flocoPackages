{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@types%2ftunnel?_rev=476-6ec0aab423728a48393f62b7dda33855";
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
    scope = "@types";
    ident = "@types/tunnel";
    ldir  = "info/types/tunnel";
    inherit packument fetchInfo;
  } // latest';

}