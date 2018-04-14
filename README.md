Install GNOME Themes
====================

This script installs the latest GitHub versions of some fine [GNOME](https://www.gnome.org/) themes into the current user's `.themes` folder. Run the script again whenever you want to get the latest theme updates. Many of these themes are updated frequently with bugfixes and enhancements.

It supports GNOME versions 3.18 and above, and will install the correct version according to your system. So if, for example, you upgrade from GNOME 3.18 to GNOME 3.20, you would want to run the script again. (GNOME 3.20 completely overhauled the theming system, so older themes are incompatible.)


Basic Usage
-----------

Get it:

    git clone https://github.com/tliron/install-gnome-themes ~/install-gnome-themes

If you already have themes of the same names installed in your `.themes` folder, they will be deleted, so backup the folder first if you want to keep them. Other themes will _not_ be touched.

Run it:
    
    ~/install-gnome-themes/install-gnome-themes

To avoid rebuilding themes if there was no change, the script caches identifiers in the file `.install-gnome-themes-cache` in the current user's `.themes` folder. Delete it to force rebuilding all themes.

To change your theme, run the GNOME Tweak Tool and go to the Appearance tab. Or, you can use the command line:

    gsettings set org.gnome.desktop.interface gtk-theme "gtk theme name"
    gsettings set org.gnome.desktop.wm.preferences theme "shell theme name"

To update this script to its latest version:

    git -C ~/install-gnome-themes pull


Requirements
------------

Building some of the themes is heavy work for (example, SASS is used to compile CSS and InkScape is used to render images) and thus this script requires some big requirements. That's the price of living on the cutting edge.

Note: some operating systems come with the Numix theme pre-installed. We will remove it to avoid conflict with our more up-to-date version.

Debian world:

    sudo apt remove numix-gtk-theme
    sudo apt install \
      git autoconf automake pkg-config parallel sassc optipng \
      ruby ruby-bundler ruby-dev \
      inkscape \
      libgtk-3-dev libgdk-pixbuf2.0-dev libglib2.0-dev libglib2.0-bin \
      libxml2-utils librsvg2-dev \
      gnome-themes-standard gtk2-engines-murrine gtk2-engines-pixbuf \
      fonts-roboto-hinted fonts-noto-hinted

Fedora world:

    sudo dnf remove numix-gtk-theme numix-icon-theme numix-icon-theme-circle
    sudo dnf install \
      git autoconf automake parallel sassc optipng \
      ruby ruby-devel rubygem-bundler libffi-devel gcc redhat-rpm-config \
      inkscape \
      gtk3-devel gdk-pixbuf2-xlib glib2-devel glib2 \
      libxml2-devel librsvg2-devel \
      gnome-themes-standard gtk-murrine-engine gtk2-engines \
      google-roboto-fonts google-noto-sans-fonts google-noto-mono-fonts

And you'll need SASS:

     gem install --user-install sass

In case your operating system doesn't have a `sassc` package, you can build it manually:

    export WORK=/tmp/install-gnome-themes
    rm --recursive --force "$WORK/libsass" "$WORK/sassc"
    mkdir --parents "$WORK"
    cd "$WORK"
    git clone https://github.com/sass/libsass.git --depth 1 libsass
    git clone https://github.com/sass/sassc.git --depth 1 sassc
    cd "$WORK/sassc"
    SASS_LIBSASS_PATH="$WORK/libsass" make --jobs="$(nproc)"
    sudo cp "$WORK/sassc/bin/sassc" /usr/bin/
    rm --recursive --force "$WORK/libsass" "$WORK/sassc"


Supported Themes
----------------

All of these themes provide at least GTK+ theming (for both GTK+3 and GTK+2) and many also provide a shell theme. You are free to mix and match GTK+ themes with shell themes! Some themes also provide application theming (Firefox, Chrome, etc.) though you will have to install that separately. For Firefox, note that there is also a generic [GNOME 3 theme](https://addons.mozilla.org/en-US/firefox/addon/adwaita/) that might improve its appearance for some themes, though your mileage will vary.

* [Adapta](https://github.com/tista500/Adapta)
* [Adwaita Tweaks](https://github.com/Jazqa/adwaita-tweaks)
* [Ant](https://github.com/EliverLara/Ant)
* [Arc](https://github.com/horst3180/arc-theme) (Firefox themes: [Arc](https://addons.mozilla.org/en-US/firefox/addon/arc-theme/), [Arc Darker](https://addons.mozilla.org/en-US/firefox/addon/arc-darker-theme/), [Arc Dark](https://addons.mozilla.org/en-US/firefox/addon/arc-dark-theme/))
* [Arc-Flatabulous](https://github.com/andreisergiu98/arc-flatabulous-theme)
* [Arc-Red](https://github.com/mclmza/arc-theme-Red)
* [Blue-Face](https://github.com/Vistaus/Blue-Face)
* [Breeze](https://github.com/dirruk1/gnome-breeze)
* [Candra](https://github.com/killhellokitty/Candra-Themes-3.20) (GNOME 3.20+ only)
* [Canta](https://github.com/vinceliuice/Canta-theme)
* [Ceti-2](https://github.com/horst3180/ceti-theme) (GNOME 3.18 only)
* [Chrome-OS](https://github.com/Elbullazul/Chrome-OS)
* [Ciliora-Secunda](https://github.com/zagortenay333/ciliora-secunda-shell)
* [Ciliora-Tertia](https://github.com/zagortenay333/ciliora-tertia-shell)
* [Cloak](https://github.com/killhellokitty/Cloak-3.22) (GNOME 3.22+ only)
* [DeLorean Dark](https://github.com/killhellokitty/DeLorean-Dark-3.18) (GNOME 3.18 only)
* [EvoPop](https://github.com/solus-cold-storage/evopop-gtk-theme)
* [Flatabulous](https://github.com/anmoljagetia/Flatabulous) (GNOME 3.18 only)
* [Flattiance](https://github.com/IonicaBizau/Flattiance) (GNOME 3.18 only)
* [Fresh-Finesse](https://github.com/Vistaus/Fresh-Finesse)
* [Greybird](https://github.com/shimmerproject/Greybird)
* [macOS-Sierra](https://github.com/Elbullazul/macOS-Sierra)
* [Materia](https://github.com/nana-4/materia-theme) (formerly Flat-Plat)
* [Minwaita](https://github.com/godlyranchdressing/Minwaita)
* [Numix](https://github.com/numixproject/numix-gtk-theme)
* [OSX-Arc Collection](https://github.com/LinxGem33/OSX-Arc-Darker)
* [Paper](https://github.com/snwh/paper-gtk-theme)
* [Plano](https://github.com/lassekongo83/plano-theme) (GNOME 3.20+ only)
* [Pop](https://github.com/pop-os/gtk-theme)
* [Pocillo](https://github.com/UbuntuBudgie/pocillo-gtk-theme)
* [Redmond-Themes](https://github.com/Elbullazul/Redmond-Themes)
* [United GNOME](https://github.com/godlyranchdressing/United-GNOME) (GNOME 3.20+ only)
* [Unity7](https://github.com/B00merang-Project/unity7)
* [Unity8](https://github.com/B00merang-Project/unity8)
* [Vertex](https://github.com/horst3180/vertex-theme)
* [Vimix](https://github.com/vinceliuice/vimix-gtk-themes)
* [Yosembiance](https://github.com/bsundman/Yosembiance) (GNOME 3.18 only)
* [Zuki](https://github.com/lassekongo83/zuki-themes)
