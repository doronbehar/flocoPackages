#! /usr/bin/env bash
# ============================================================================ #
#
#
#
# ---------------------------------------------------------------------------- #

: "${NIX:=nix}";
: "${REALPATH:=realpath}";
: "${SORT:=sort}";

: "${SCCMAP:=$NIX shell nixpkgs#graphviz -c sccmap}";
: "${GVPR:=$NIX shell nixpkgs#graphviz -c gvpr}";


# ---------------------------------------------------------------------------- #

SPATH="$( $REALPATH "${BASH_SOURCE[0]}"; )";
SDIR="${SPATH%/*}";


# ---------------------------------------------------------------------------- #

#shellcheck disable=SC2016
$SDIR/dumpDOT.sh|$SCCMAP|$GVPR 'BEG_G {}
N { if ( $G.name != "scc_map" ) { print( $.name ); } }
'|$SORT -u;


# ---------------------------------------------------------------------------- #
#
#
#
# ============================================================================ #
