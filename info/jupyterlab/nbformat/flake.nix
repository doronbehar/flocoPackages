{

  inputs.packument.url   = "https://registry.npmjs.org/@jupyterlab/nbformat?rev=279-6b2f17733e5dd5a6b457d627e4f6fed8";
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
    scope = "@jupyterlab";
    ident = "@jupyterlab/nbformat";
    ldir  = "info/jupyterlab/nbformat";
    inherit packument fetchInfo;
  } // latest';

}
