#!/bin/sh


mkdir $HOME/.config/discorder/

# Required Vala to C compiler, GTK3 library, WebKit2GTK(devel) and GCC (or Clang).
sudo valac --pkg gtk+-3.0 --pkg webkit2gtk-4.0 Discorder.vala -o /bin/discorder

sudo mkdir /usr/share/pixmaps/discorder/

sudo cp resource/*.png /usr/share/pixmaps/discorder/

sudo cp discorder.desktop /usr/share/applications/
