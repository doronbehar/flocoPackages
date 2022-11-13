# ============================================================================ #
#
# Overlays Nixpkgs.
#
# ---------------------------------------------------------------------------- #

final: prev: let

# ---------------------------------------------------------------------------- #

  infoDir = ../../info;

  # Packages explicitly marked for export.
  marked = prev.lib.importJSON ./npmjs.json;

# ---------------------------------------------------------------------------- #

  allFetchInfoDefs = let
    subdirsOf = d: let
      des = builtins.readDir d;
      proc = acc: name:
        if des.${name} != "directory" then acc else acc ++ [name];
    in builtins.foldl' proc [] ( builtins.attrNames des );
    scopes = subdirsOf infoDir;
    scopeBnames = s:
      if s != "unscoped" then subdirsOf ( infoDir + "/${s}" ) else
      builtins.concatMap ( l: subdirsOf ( infoDir + "/unscoped/${l}" ) )
                         ( subdirsOf ( infoDir + "/unscoped" ) );
    hier =
      builtins.foldl' ( acc: s: acc // { ${s} = scopeBnames s; } ) {} scopes;
  in hier;


# ---------------------------------------------------------------------------- #

  definedIn = {
    scope   ? if final.lib.test "@.*" ident
              then final.lib.yank "@([^@/]+)/.*" ident
              else "unscoped"
  , bname   ? baseNameOf ident
  , key     ? null #"${ident}/${version}"
  , ident   ? if args ? key then dirOf key else
              if scope == "unscoped" then bname else "@${scope}/${bname}"
  #, version ? baseNameOf args.key
  } @ args: let
    bins    = final.lib.importJSONOr {} ../BINS/npmjs.json;
    inst    = final.lib.importJSONOr {} ../INST/npmjs.json;
    gyp     = final.lib.importJSONOr {} ../GYP/npmjs.json;
    simple  = final.lib.importJSONOr {} ../SIMPLE/npmjs.json;
    hierHas = h: ( h ? ${scope} ) && ( builtins.elem bname h.${scope} );
    shard   = prev.lib.toLower ( builtins.substring 0 1 bname );
    dir     = if ( scope == null ) || ( scope == "unscoped" )
              then infoDir + "/unscoped/${shard}/${bname}"
              else infoDir + "/${scope}/${bname}";
  in if hierHas bins   then "bins"   else
     if hierHas inst   then "inst"   else
     if hierHas gyp    then "gyp"    else
     if hierHas simple then "simple" else
     #if builtins.pathExists "${dir}/fetchInfo.json" then "info" else
     null;

  shouldExport = x: builtins.elem ( definedIn x ) ["info" "simple"];

  #marked = let
  #  filt = scope: bnames:
  #    builtins.filter ( bname: shouldExport { inherit scope bname; } ) bnames;
  #in builtins.mapAttrs filt allFetchInfoDefs;


# ---------------------------------------------------------------------------- #

  loadFetchInfo' = {
    scope
  , bname
  , shard ? prev.lib.toLower ( builtins.substring 0 1 bname )
  }: let
    ident = if ( scope == null ) || ( scope == "unscoped" ) then bname else
            "@${scope}/${bname}";
    dir = if ( scope == null ) || ( scope == "unscoped" )
          then infoDir + "/unscoped/${shard}/${bname}"
          else infoDir + "/${scope}/${bname}";
    byVers = prev.lib.importJSON "${dir}/fetchInfo.json";
    allVersions = builtins.attrNames byVers;
    filt = vs: let
      releases = builtins.filter final.lib.librange.isRelease vs;
      gmajor = builtins.groupBy ( prev.lib.yank "([^.]+)\\..*" ) releases;
      gminor =
        builtins.groupBy ( prev.lib.yank "([^.]+\\.[^.]+)\\..*" ) releases;
      minors = let
        byMinor =
          builtins.mapAttrs ( _: final.lib.latestVersion ) gminor;
      in builtins.concatLists ( builtins.attrValues byMinor );
      highestMajor = let
        desc = a: b: b < a;
      in builtins.head ( builtins.sort desc ( builtins.attrNames gmajor ) );
    in if ( builtins.length vs ) < 10 then vs else
       minors ++ ( prev.lib.take 10 gmajor.${highestMajor} );
    proc = acc: v: acc // { "${ident}/${v}" = byVers.${v}; };
  in builtins.foldl' proc {} ( builtins.attrNames byVers );

  loadFetchInfo = ident: let
    m = builtins.match "(@?([^@/]+)/)?(([^@/])([^@/]+))" ident;
  in loadFetchInfo' {
    scope = builtins.elemAt m 1;
    bname = builtins.elemAt m 2;
    shard = prev.lib.toLower ( builtins.elemAt m 3 );
  };

  markedFetchInfos = let
    asSb = scope: let
      proc = acc: bname: acc // {
        ${bname} = loadFetchInfo' { inherit scope bname; };
      };
    in builtins.foldl' proc {};
  in builtins.mapAttrs asSb marked;


# ---------------------------------------------------------------------------- #

in {

  __internalSimple = {
    inherit
      marked
      allFetchInfoDefs
      markedFetchInfos
      definedIn
      loadFetchInfo'
      loadFetchInfo
    ;
  };


# ---------------------------------------------------------------------------- #

  # Produces store paths from `./locked.json' tree entries.
  # In the case of `type = "file"' entries we produce a derivation of the
  # unpacked tarball; for `type = "tarball"' entries we just produce storepaths.
  flocoSimpleFetcher = { fetchInfo, ... } @ ent: let
    fetched  = builtins.fetchTree fetchInfo;
    unpacked = final.flocoUnpack {
      name        = "source";
      tarball     = fetched;
      setBinPerms = false;   # None of these have bins.
    };
    src = if fetchInfo.type == "file" then unpacked else fetched;
  in ent // { sourceInfo = src; inherit (src) outPath; };

  flocoPackages = prev.flocoPackages.extend ( fpFinal: fpPrev: let
    proc = acc: scope: let
      procS = accS: bname: let
        ident   = if scope == "unscoped" then bname else "@${scope}/${bname}";
        fis     = markedFetchInfos.${scope}.${bname};
        latestV = let
          allVers  = map baseNameOf ( builtins.attrNames fis );
          releases = builtins.filter final.lib.librange.isRelease allVers;
          versions = if releases == [] then allVers else releases;
          latest   = final.lib.latestVersion versions;
          msg      = "${ident} has no versions in its 'fetchInfo' file";
        in if ( builtins.length allVers ) < 1 then throw msg else latest;
        extra = { "${ident}/latest" = fpFinal."${ident}/${latestV}"; };
        addV  = builtins.mapAttrs ( _: fetchInfo:
          final.flocoSimpleFetcher { inherit fetchInfo; }
        ) fis;
      in accS // addV // extra;
      addsB = builtins.foldl' procS {}
                              ( builtins.attrNames markedFetchInfos.${scope} );
    in acc // addsB;
    exported = builtins.foldl' proc {} ( builtins.attrNames markedFetchInfos );
  in ( exported // {
    # Add any explicit defs here.
    "@azure/msal-node/1.0.0-beta.6" = let
      fis = prev.lib.importJSON ( infoDir + "/azure/msal-node/fetchInfo.json" );
    in final.flocoSimpleFetcher { fetchInfo = fis."1.0.0-beta.6"; };

    # FIXME: these are installed packages but we can get away with a copy.
    # Move to `GYP' later.
    "dtrace-provider/0.8.8" = let
      fis = prev.lib.importJSON
              ( infoDir + "/unscoped/d/dtrace-provider/fetchInfo.json" );
    in final.flocoSimpleFetcher { fetchInfo = fis."0.8.8"; };
    "fsevents/2.3.2" = let
      fis = prev.lib.importJSON
              ( infoDir + "/unscoped/f/fsevents/fetchInfo.json" );
    in final.flocoSimpleFetcher { fetchInfo = fis."2.3.2"; };
    "keytar/7.9.0" = let
      fis = prev.lib.importJSON
              ( infoDir + "/unscoped/k/keytar/fetchInfo.json" );
    in final.flocoSimpleFetcher { fetchInfo = fis."7.9.0"; };
  } ) );

}


# ---------------------------------------------------------------------------- #
#
#
#
# ============================================================================ #
