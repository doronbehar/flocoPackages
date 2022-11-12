{

  inputs.packument.url   = "https://skimdb.npmjs.com/registry/@opentelemetry/otlp-transformer?_rev=6-ff6ae9327b4d50916b65a453eac3f698";
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
    scope = "@opentelemetry";
    ident = "@opentelemetry/otlp-transformer";
    ldir  = "info/opentelemetry/otlp-transformer";
    inherit packument fetchInfo;
  } // latest';

}
