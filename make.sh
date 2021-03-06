#!/bin/sh

# Required Vala to C compiler, GTK3 library, WebKit2GTK(devel) and GCC (or Clang).
valac --pkg gtk+-3.0 --pkg webkit2gtk-4.0 Discorder.vala -o discorder

mkdir /usr/share/pixmaps/discorder/

mkdir /home/$USERNAME/.config/discorder/

cp resource/*.png /usr/share/pixmaps/discorder/

cp discorder.desktop /usr/share/applications/
