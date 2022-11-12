{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@protobufjs%2fpath?_rev=9-ca19a858213bf75b0070afb621952207";
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
    scope = "@protobufjs";
    ident = "@protobufjs/path";
    ldir  = "info/protobufjs/path";
    inherit packument fetchInfo;
  } // latest';

}
