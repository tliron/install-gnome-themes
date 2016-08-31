Install GNOME Themes
====================

This script installs the latest GitHub versions of some fine [GNOME](https://www.gnome.org/) themes into the current user's `.themes` folder.

It is safe to run the script again and again to get up to date with the latest versions. Note that when running, the script will announce the time of the last update.

The script supports both GNOME 3.20 and GNOME 3.18, and will install the correct version according to your system. So if you upgrade from GNOME 3.18 to GNOME 3.20, you would want to run the script again. (GNOME 3.20 completely overhauled the theming system, so older themes are incompatible.)

All of these themes provide at least GTK+ theming (for both GTK+3 and GTK+2) and many also provide a shell theme. You are free to mix and match GTK+ themes with shell themes! Some themes also provide application theming (Firefox, Chrome, etc.) though you will have to install that separately. For Firefox, note that there is also a generic [GNOME 3 theme](https://addons.mozilla.org/en-US/firefox/addon/adwaita/) that might improve its appearance for some themes, though your mileage will vary.

To change your theme, run GNOME Tweak and go to the Appearance tab.

If you already have themes of the same names installed in your `.themes` folder, they will be deleted, so backup the folder first if you want to keep them. Other themes will _not_ be touched.

Supported Themes
----------------

* [Adapta](https://github.com/tista500/Adapta)
* [Arc](https://github.com/horst3180/arc-theme) (Firefox themes: [Arc](https://addons.mozilla.org/en-US/firefox/addon/arc-theme/), [Arc Darker](https://addons.mozilla.org/en-US/firefox/addon/arc-darker-theme/), [Arc Dark](https://addons.mozilla.org/en-US/firefox/addon/arc-dark-theme/))
* [Arc-Red](https://github.com/mclmza/arc-theme-Red)
* [Breeze](https://github.com/dirruk1/gnome-breeze)
* [Candra](https://github.com/killhellokitty/Candra-Themes-3.20) (GNOME 3.20 only)
* [Ceti-2](https://github.com/horst3180/ceti-theme) (GNOME 3.18 only)
* [Cloak](https://github.com/killhellokitty/Cloak-3.20) (GNOME 3.20 only)
* [DeLorean Dark](https://github.com/killhellokitty/DeLorean-Dark-3.18) (GNOME 3.18 only)
* [EvoPop](https://github.com/solus-cold-storage/evopop-gtk-theme)
* [Flat-Plat](https://github.com/nana-4/Flat-Plat)
* [Fresh-Finesse](https://github.com/Vistaus/Fresh-Finesse)
* [Greybird](https://github.com/shimmerproject/Greybird)
* [Numix](https://github.com/numixproject/numix-gtk-theme)
* [OS X El Capitan](https://github.com/Elbullazul/OS-X-El-Capitan/tree/master/OS%20X%20El%20Capitan)
* [Paper](https://github.com/snwh/paper-gtk-theme)
* [Vertex](https://github.com/horst3180/vertex-theme)
* [Zuki](https://github.com/lassekongo83/zuki-themes)

TODO
----

Please contribute with pull requests! Especially needed:

* Currently designed for Ubuntu/Debian, but should be modified for other free operating systems.
* Optimization: we should check if the version is indeed newer before installing. (We can save the SHA-1 of the latest git commit and support a `--force` flag to ignore it.)

