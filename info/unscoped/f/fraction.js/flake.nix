{

  inputs.packument.url   = "https://registry.npmjs.org/fraction.js?rev=58-40c3264395787ab143b1899f9a0ac0e6";
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
    ident = "fraction.js";
    ldir  = "info/unscoped/f/fraction.js";
    inherit packument fetchInfo;
  } // latest';

}
