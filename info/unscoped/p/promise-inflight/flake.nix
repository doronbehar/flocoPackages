{

  inputs.packument.url   = "https://registry.npmjs.org/promise-inflight?rev=4-28ae9dd47aae514345e5fad190adaf44";
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
    ident = "promise-inflight";
    ldir  = "info/unscoped/p/promise-inflight";
    inherit packument fetchInfo;
  } // latest';

}
