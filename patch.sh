#!/bin/bash
set -e

OPERATION=$1

THEMES=~/.themes

function font_weight () {
	sed -i '/\/\* PATCH \(.*\) \*\//! s/font-weight: 500;/\/\* PATCH font-weight: 500; \*\//g' "$1"
}

function reset () {
	sed -i 's/\/\* PATCH \(.*\) \*\//\1/g' "$1"
}

function patch () {
	local THEME=$1
	"$OPERATION" "$THEMES/$THEME/gtk-3.0/gtk.css"
	"$OPERATION" "$THEMES/$THEME/gtk-3.0/gtk-dark.css"
	"$OPERATION" "$THEMES/$THEME/gnome-shell/gnome-shell.css"
}

patch Materia

echo Done!
