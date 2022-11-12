{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@types%2fmsgpack?_rev=518-4ff9d75ab46abc1a3aa7043f2d8a9fec";
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
    ident = "@types/msgpack";
    ldir  = "info/types/msgpack";
    inherit packument fetchInfo;
  } // latest';

}