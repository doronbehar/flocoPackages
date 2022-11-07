{

  inputs.packument.url   = "https://registry.npmjs.org/micromark-util-subtokenize?rev=8-549933bca524e7b00e5a7aacc239a180";
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
    ident = "micromark-util-subtokenize";
    ldir  = "info/unscoped/m/micromark-util-subtokenize";
    inherit packument fetchInfo;
  } // latest';

}
