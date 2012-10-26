#!/bin/bash
# Copyright (C) 2012 Phantom X. All rights reserved. This
# copyrighted material is made available to anyone wishing to use, modify,
# copy, or redistribute it subject to the terms and conditions of the
# GNU General Public License version 2.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
# Workarounds for XDG directories
if [ -n "${HOME}" -a -z "${XDG_DATA_HOME}" ]; then
  export XDG_DATA_HOME="${HOME}/.local/share"
  mkdir -p "${XDG_DATA_HOME}"
fi
if [ -n "${HOME}" -a -z "${XDG_CONFIG_HOME}" ]; then
  export XDG_CONFIG_HOME="${HOME}/.config"
  mkdir -p "${XDG_CONFIG_HOME}"
fi
if [ -n "${HOME}" -a -z "${XDG_CACHE_HOME}" ]; then
  export XDG_CACHE_HOME="${HOME}/.cache"
  mkdir -p "${XDG_CACHE_HOME}"
fi
if [ -n "${HOME}" -a -z "${XDG_RUNTIME_DIR}" ]; then
  # Ugly, but...
  export XDG_RUNTIME_DIR="/tmp/.run-${USER}"
  mkdir -p "${XDG_RUNTIME_DIR}"
  chmod 0700 "${XDG_RUNTIME_DIR}"
fi

