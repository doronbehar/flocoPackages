{

  inputs.packument.url   = "https://registry.npmjs.org/combined-stream?rev=45-8071877f56d51159c12935cada0a84d7";
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
    ident = "combined-stream";
    ldir  = "info/unscoped/c/combined-stream";
    inherit packument fetchInfo;
  } // latest';

}
