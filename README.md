Install GNOME Themes
====================

This script installs the latest versions of some fine GNOME 3 themes into the current user's `.themes` folder.

It supports both GNOME 3.20 and GNOME 3.18, and will install the correct version according to your system.

It is safe to run the script again and again to get all latest versions. When running, the script will announce the time of the last update.

If you already have themes of the same names installed there, they will be deleted, so perhaps you would want to backup the folder first.

Supported Themes
----------------

* [Adapta](https://github.com/tista500/Adapta)
* [Arc](https://github.com/horst3180/arc-theme)
* [Candra](https://github.com/killhellokitty/Candra-Themes-3.20) (GNOME 3.20 only)
* [Ceti-2](https://github.com/horst3180/ceti-theme) (GNOME 3.18 only)
* [Cloak](https://github.com/killhellokitty/Cloak-3.20) (GNOME 3.20 only)
* [DeLorean Dark](https://github.com/killhellokitty/DeLorean-Dark-3.18) (GNOME 3.18 only)
* [Numix](https://github.com/numixproject/numix-gtk-theme)
* [Paper](https://github.com/snwh/paper-gtk-theme)
* [Vertex](https://github.com/horst3180/vertex-theme)
* [Zuki](https://github.com/lassekongo83/zuki-themes)

TODO
----

Please contribute with pull requests!

* Currently designed for Ubuntu/Debian, but should be modified for other free operating systems, with detection.
* Should check if the version is indeed newer before installing. (We can save the SHA-1 of the latest git commit and support a `--force` flag to ignore it.)

