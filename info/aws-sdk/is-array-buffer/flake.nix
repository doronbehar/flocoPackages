{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@aws-sdk%2fis-array-buffer?_rev=68-9a375758369fd0b57239d730a48a0651";
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
    scope = "@aws-sdk";
    ident = "@aws-sdk/is-array-buffer";
    ldir  = "info/aws-sdk/is-array-buffer";
    inherit packument fetchInfo;
  } // latest';

}
