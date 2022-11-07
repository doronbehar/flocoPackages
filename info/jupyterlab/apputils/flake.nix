{

  inputs.packument.url   = "https://registry.npmjs.org/@jupyterlab/apputils?rev=451-65750a48fdedab7d4ac2b4087f651457";
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
    ident = "@jupyterlab/apputils";
    ldir  = "info/jupyterlab/apputils";
    inherit packument fetchInfo;
  } // latest';

}
