Install GNOME Themes
====================

This script installs the latest GitHub versions of some fine [GNOME](https://www.gnome.org/) themes into the current user's `.themes` folder. Run the script again whenever you want to get the latest theme updates! Many of themes are constantly being updated with bugfixes and enhancements.

The script supports GNOME versions 3.18 to 3.24, and will install the correct version according to your system. So if, for example, you upgrade from GNOME 3.18 to GNOME 3.20, you would want to run the script again. (GNOME 3.20 completely overhauled the theming system, so older themes are incompatible.)

All of these themes provide at least GTK+ theming (for both GTK+3 and GTK+2) and many also provide a shell theme. You are free to mix and match GTK+ themes with shell themes! Some themes also provide application theming (Firefox, Chrome, etc.) though you will have to install that separately. For Firefox, note that there is also a generic [GNOME 3 theme](https://addons.mozilla.org/en-US/firefox/addon/adwaita/) that might improve its appearance for some themes, though your mileage will vary.

To change your theme, run the GNOME Tweak Tool and go to the Appearance tab.

To avoid rebuilding themes if there was no change, the script caches identifiers in the file `.install-gnome-themes-cache` in the current user's `.themes` folder. Delete it to force rebuilding all themes.

If you already have themes of the same names installed in your `.themes` folder, they will be deleted, so backup the folder first if you want to keep them. Other themes will _not_ be touched.


Instructions
------------

Ubuntu:

    sudo apt install git
    git clone https://github.com/tliron/install-gnome-themes ~/install-gnome-themes
    ~/install-gnome-themes/install-gnome-themes

To update this script to the latest version:

    cd ~/install-gnome-themes
    git pull


Supported Themes
----------------

* [Adapta](https://github.com/tista500/Adapta)
* [Adwaita-compact](https://github.com/abihf/adwaita-compact)
* [Arc](https://github.com/horst3180/arc-theme) (Firefox themes: [Arc](https://addons.mozilla.org/en-US/firefox/addon/arc-theme/), [Arc Darker](https://addons.mozilla.org/en-US/firefox/addon/arc-darker-theme/), [Arc Dark](https://addons.mozilla.org/en-US/firefox/addon/arc-dark-theme/))
* [Arc-Flatabulous](https://github.com/andreisergiu98/arc-flatabulous-theme)
* [Arc-Red](https://github.com/mclmza/arc-theme-Red)
* [Breeze](https://github.com/dirruk1/gnome-breeze)
* [Candra](https://github.com/killhellokitty/Candra-Themes-3.20) (GNOME 3.20+ only)
* [Ceti-2](https://github.com/horst3180/ceti-theme) (GNOME 3.18 only)
* [Cloak](https://github.com/killhellokitty/Cloak-3.20) (GNOME 3.20+ only)
* [DeLorean Dark](https://github.com/killhellokitty/DeLorean-Dark-3.18) (GNOME 3.18 only)
* [EvoPop](https://github.com/solus-cold-storage/evopop-gtk-theme)
* [Flat-Plat](https://github.com/nana-4/Flat-Plat)
* [Flatabulous](https://github.com/anmoljagetia/Flatabulous) (GNOME 3.18 only)
* [Flattiance](https://github.com/IonicaBizau/Flattiance) (GNOME 3.18 only)
* [Fresh-Finesse](https://github.com/Vistaus/Fresh-Finesse)
* [Greybird](https://github.com/shimmerproject/Greybird)
* [macOS-Sierra](https://github.com/Elbullazul/macOS-Sierra)
* [Numix](https://github.com/numixproject/numix-gtk-theme)
* [Paper](https://github.com/snwh/paper-gtk-theme)
* [Plano](https://github.com/lassekongo83/plano-theme) (GNOME 3.20+ only)
* [Redmond-Themes](https://github.com/Elbullazul/Redmond-Themes)
* [Vertex](https://github.com/horst3180/vertex-theme)
* [Vimix](https://github.com/vinceliuice/vimix-gtk-themes)
* [Yosembiance](https://github.com/bsundman/Yosembiance) (GNOME 3.18 only)
* [Zuki](https://github.com/lassekongo83/zuki-themes)


TODO
----

Please contribute with pull requests! Especially needed:

* Currently designed for Ubuntu/Debian, but should be modified for other free operating systems.

