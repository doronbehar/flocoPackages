{

  inputs.packument.url   = "https://registry.npmjs.org/array.prototype.filter?rev=10-073e643c34690cb55b2aba6bcb6651ab";
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
    ident = "array.prototype.filter";
    ldir  = "info/unscoped/a/array.prototype.filter";
    inherit packument fetchInfo;
  } // latest';

}
