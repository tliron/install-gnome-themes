Install GNOME Themes
====================

This script installs the latest git versions of some fine [GNOME](https://www.gnome.org/) themes
into the current user's `.themes` folder. Run the script again whenever you want to get the latest
theme updates. Many of these themes are updated frequently with bugfixes and enhancements.

It supports GNOME versions 3.22 and above.


Preparation
-----------

You need to install the requirements first. See
[install-requirements-fedora](install-requirements-fedora) and
[install-requirements-debian](install-requirements-debian). The Debian script should work for
Ubuntu, too. We welcome contributions for other operating systems, too, especially Arch Linux!

In case your operating system doesn't have a `sassc` package you can build it manually with
[install-sassc](install-sassc).

Now, get the script:

    git clone https://github.com/tliron/install-gnome-themes ~/install-gnome-themes

If you already have themes of the same names installed in your `.themes` folder, they will be
deleted, so backup the folder first if you want to keep them. Other themes will _not_ be touched.


Installing Themes
-----------------

You can update this script to its latest version and run it like so:

    git -C ~/install-gnome-themes pull --ff-only
    ~/install-gnome-themes/install-gnome-themes

Note that it will take some time, because some themes render all their images during build.

To change your theme, run the GNOME Tweak Tool and go to the Appearance tab. Or, you can use the
command line:

    gsettings set org.gnome.desktop.interface gtk-theme "GTK theme name"
    gsettings set org.gnome.desktop.wm.preferences theme "Shell theme name"

To avoid rebuilding themes if there was no change the script caches identifiers in the file
`.install-gnome-themes.conf` in the current user's `.themes` folder. Delete it to force rebuilding
all themes:

    rm ~/.themes/.install-gnome-themes.conf


Disabling Themes
----------------

You can disable individual themes in case they're broken or you just don't want them built. 

Edit the `.install-gnome-themes.conf` in the current user's `.themes` folder and put the word "skip"
instead of the git hash. For example, to skip Plano themes:

    github|lassekongo83|plano-theme|master skip


Uninstalling Themes
-------------------

You can uninstall individual themes by deleting their directories in your `.themes` folder. To
uninstall *all* user themes, *including themes not installed by this script*, delete the entire
directory:

    rm -r ~/.themes

Note that themes take very little space (less than 300 MB for all themes combined) and do not slow
down your system when unused.


Problems?
---------

Because we are tracking the latest versions of themes, there is a chance something will break.
Please help us fix it and [open an issue](https://github.com/tliron/install-gnome-themes/issues)
with as much detail as you can!

By default the script logs all output to the file `.install-gnome-themes.log` in the current user's
`.themes` folder, but you can also send it to the console like so:

    LOG=/dev/stdout ~/install-gnome-themes/install-gnome-themes


Supported Themes
----------------

All of these themes provide at least GTK+ theming (for both GTK+3 and GTK+2) and many also provide a
shell theme. You are free to mix and match GTK+ themes with shell themes! Some themes also provide
application theming (Firefox, Chrome, etc.) though you will have to install that separately. For
Firefox, note that there is also a generic
[GNOME 3 theme](https://addons.mozilla.org/en-US/firefox/addon/adwaita/) that might improve its
appearance for some themes, though your mileage will vary.

* [Adapta](https://github.com/tista500/Adapta)
* [Adwaita Tweaks](https://github.com/Jazqa/adwaita-tweaks)
* [Amber](https://github.com/lassekongo83/amber-theme)
* [Ant](https://github.com/EliverLara/Ant)
* [Aqua](https://github.com/EliverLara/Aqua)
* [Arc](https://github.com/jnsh/arc-theme) (Firefox themes: [Arc](https://addons.mozilla.org/en-US/firefox/addon/arc-theme/), [Arc Darker](https://addons.mozilla.org/en-US/firefox/addon/arc-darker-theme/), [Arc Dark](https://addons.mozilla.org/en-US/firefox/addon/arc-dark-theme/))
* [Arc-Flatabulous](https://github.com/andreisergiu98/arc-flatabulous-theme)
* [Blue-Face](https://github.com/Vistaus/Blue-Face)
* [Breeze](https://github.com/dirruk1/gnome-breeze)
* [Candra](https://github.com/killhellokitty/Candra-Themes-3.20)
* [Canta](https://github.com/vinceliuice/Canta-theme)
* [Chrome-OS](https://github.com/Elbullazul/Chrome-OS)
* [Ciliora-Secunda](https://github.com/zagortenay333/ciliora-secunda-shell)
* [Ciliora-Tertia](https://github.com/zagortenay333/ciliora-tertia-shell)
* [Cloak](https://github.com/killhellokitty/Cloak-3.22)
* [EvoPop](https://github.com/solus-cold-storage/evopop-gtk-theme)
* [Fresh-Finesse](https://github.com/Vistaus/Fresh-Finesse)
* [Greybird](https://github.com/shimmerproject/Greybird)
* [Layan](https://github.com/vinceliuice/Layan-gtk-theme)
* [macOS-Sierra](https://github.com/Elbullazul/macOS-Sierra)
* [Materia](https://github.com/nana-4/materia-theme) (formerly Flat-Plat)
* [Materiav2](https://gitlab.com/Gsbhasin84/materiav2)
* [Minwaita](https://github.com/godlyranchdressing/Minwaita)
* [Mojave](https://github.com/vinceliuice/Mojave-gtk-theme) ([Firefox theme](https://github.com/vinceliuice/Mojave-gtk-theme/blob/master/src/other/firefox))
* [Nephrite](https://github.com/vinceliuice/Nephrite-gtk-theme)
* [Nordic](https://github.com/EliverLara/Nordic)
* [Numix](https://github.com/numixproject/numix-gtk-theme)
* [Numix-Base16-Ocean](https://gitlab.com/commonacc/numix-base16-ocean)
* [Orchis](https://github.com/vinceliuice/Orchis-theme) ([Firefox theme](https://github.com/vinceliuice/Orchis-theme/tree/master/src/firefox))
* [OSX-Arc-Darker](https://github.com/rufkeya/OSX-Arc-Darker)
* [Paper](https://github.com/snwh/paper-gtk-theme)
* [Plano](https://github.com/lassekongo83/plano-theme)
* [Plata](https://gitlab.com/tista500/plata-theme)
* [Pocillo](https://github.com/UbuntuBudgie/pocillo-gtk-theme)
* [Pop](https://github.com/pop-os/gtk-theme)
* [Qogir](https://github.com/vinceliuice/Qogir-theme)
* [Skeuos](https://github.com/daniruiz/skeuos-gtk)
* [Typewriter](https://github.com/logico-dev/typewriter-gtk/)
* [United GNOME](https://github.com/godlyranchdressing/United-GNOME)
* [Unity7](https://github.com/B00merang-Project/unity7)
* [Unity8](https://github.com/B00merang-Project/unity8)
* [Vertex](https://github.com/horst3180/vertex-theme)
* [Vimix](https://github.com/vinceliuice/vimix-gtk-themes)
* [Windows 3.11](https://github.com/B00merang-Project/Windows-3.11)
* [Windows 7](https://github.com/B00merang-Project/Windows-7)
* [Windows 8.1](https://github.com/B00merang-Project/Windows-8.1)
* [Windows 8.1 Metro](https://github.com/B00merang-Project/Windows-8.1-Metro)
* [Windows 10](https://github.com/B00merang-Project/Windows-10)
* [Windows 10 Acrylic](https://github.com/B00merang-Project/Windows-10-Acrylic)
* [Windows 10 Acrylic Dark](https://github.com/B00merang-Project/Windows-10-Acrylic-Dark)
* [Windows 10 Dark](https://github.com/B00merang-Project/Windows-10-Dark)
* [Windows 95](https://github.com/B00merang-Project/Windows-95)
* [Windows 8.1](https://github.com/B00merang-Project/Windows-Phone-8.1)
* [Windows Vista](https://github.com/B00merang-Project/Windows-Vista)
* [Windows XP](https://github.com/B00merang-Project/Windows-XP)
* [Xenlism-Minimalism](https://github.com/xenlism/minimalism)
* [Yaru](https://github.com/ubuntu/yaru) (formerly Communitheme)
* [Zuki](https://github.com/lassekongo83/zuki-themes)


Unsupported Themes
------------------

These themes only work for GNOME 3.18, which used a different theme system.

* [Ceti-2](https://github.com/horst3180/ceti-theme)
* [DeLorean Dark](https://github.com/killhellokitty/DeLorean-Dark-3.18)
* [Flatabulous](https://github.com/anmoljagetia/Flatabulous)
* [Flattiance](https://github.com/IonicaBizau/Flattiance)
* [Yosembiance](https://github.com/bsundman/Yosembiance)
