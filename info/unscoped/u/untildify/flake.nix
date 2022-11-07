{

  inputs.packument.url   = "https://registry.npmjs.org/untildify?rev=24-61b086681f092f9a0abb33e5e736eefa";
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
    ident = "untildify";
    ldir  = "info/unscoped/u/untildify";
    inherit packument fetchInfo;
  } // latest';

}
