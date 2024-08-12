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

if [[ ${EUID} -eq 0 ]]; then
    bin_dir="$(${qtpaths_binary} --query QT_HOST_PREFIX)/bin"
    desktop_dir="$(${qtpaths_binary} --locate-dirs GenericDataLocation kio/servicemenus | sed "s/.*://")"
    doc_dir="$(${qtpaths_binary} --query QT_INSTALL_PREFIX)/share/doc/kde-service-menu-reimage/"
    install_mode="system"
else
    bin_dir="${HOME}/.local/bin"
    desktop_dir="$(${qtpaths_binary} --locate-dirs GenericDataLocation kio/servicemenus | sed "s/:.*//")"
    doc_dir="${HOME}/share/doc/kde-service-menu-reimage/"
    install_mode="local"
fi

# proceed with uninstallation only if required vars are set
if [ -z "${bin_dir}" ] || [ -z "${desktop_dir}" ] || [ -z "${doc_dir}" ]; then
    echo "ERROR: Required variable(s) were not set successfully. Aborting uninstallation of kde-service-menu-reimage."
else
    echo "INFO: Uninstalling kde-service-menu-reimage (${install_mode}) ..."
    # remove binaries
    echo "Removing ${bin_dir}/reimage-kdialog"; rm "${bin_dir}/reimage-kdialog"
    # remove service menu desktop files
    desktop_files=("reimage-compress-resize.desktop" "reimage-convert-rotate.desktop" "reimage-metadata.desktop" "reimage-tools.desktop")
    for file in "${desktop_files[@]}"; do
        echo "Removing ${desktop_dir}/${file}"; rm "${desktop_dir}/${file}"
    done
    # remove docs
    echo "Removing ${doc_dir}"; rm -rf "${doc_dir}"
    echo "SUCCESS: kde-service-menu-reimage has been removed. Goodbye!"
fi
