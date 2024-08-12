#! /bin/bash
#
# 	Part of kde-service-menu-reimage Version 2.6.0
# 	Copyright (C) 2018-2019 Giuseppe Benigno <giuseppe.benigno(at)gmail.com>
# 	Copyright (C) 2024 Robert-André Mauchin <zebob.m(at)gmail.com>
#
# 	This program is free software: you can redistribute it and/or modify
# 	it under the terms of the GNU General Public License as published by
# 	the Free Software Foundation, either version 3 of the License, or
# 	(at your option) any later version.
#
# 	This program is distributed in the hope that it will be useful,
# 	but WITHOUT ANY WARRANTY; without even the implied warranty of
# 	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# 	GNU General Public License for more details.
#
# 	You should have received a copy of the GNU General Public License
# 	along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# SPDX-License-Identifier: GPL-3.0-or-later
#

qtpaths_binary="${qtpaths_binary:-"qtpaths6"}"

if [[ $EUID -eq 0 ]]; then
    bin_dir="$(${qtpaths_binary} --query QT_HOST_PREFIX)/bin"
    desktop_dir="$(${qtpaths_binary} --locate-dirs GenericDataLocation kio/servicemenus | sed "s/.*://")"
    doc_dir="$(${qtpaths_binary} --query QT_INSTALL_PREFIX)/share/doc/kde-service-menu-reimage/"
    echo "Removing kde-service-menu-reimage system wide"
else
    bin_dir="$HOME/.local/bin"
    desktop_dir="$(${qtpaths_binary} --locate-dirs GenericDataLocation kio/servicemenus | sed "s/:.*//")"
    doc_dir=$HOME"/share/doc/kde-service-menu-reimage/"
    echo "Removing kde-service-menu-reimage locally"
fi

# proceed with uninstallation only if required vars are set
if [ -z "${bin_dir}" ] || [ -z "${desktop_dir}" ] || [ -z "${doc_dir}" ]; then
    echo "ERROR: Required variable(s) were not set successfully. Aborting uninstallation of kde-service-menu-reimage."
else
    echo "removing ${bin_dir}/reimage-kdialog"
    rm "${bin_dir}/reimage-kdialog"

    echo "removing ${desktop_dir}/reimage-compress-resize.desktop"
    rm "${desktop_dir}/reimage-compress-resize.desktop"
    echo "removing ${desktop_dir}/reimage-convert-rotate.desktop"
    rm "${desktop_dir}/reimage-convert-rotate.desktop"
    echo "removing ${desktop_dir}/reimage-metadata.desktop"
    rm "${desktop_dir}/reimage-metadata.desktop"
    echo "removing ${desktop_dir}/reimage-tools.desktop"
    rm "${desktop_dir}/reimage-tools.desktop"

    echo "removing ${doc_dir}"
    rm -rf "${doc_dir}"

    echo
    echo "kde-service-menu-reimage has been removed. Good bye."
fi
