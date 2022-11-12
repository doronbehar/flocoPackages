{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/esbuild-linux-riscv64?_rev=49-52ca75f546f3e4e52c63ea33e41205c6";
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
    ident = "esbuild-linux-riscv64";
    ldir  = "info/unscoped/e/esbuild-linux-riscv64";
    inherit packument fetchInfo;
  } // latest';

}
