#!/bin/bash
# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
# ex: ts=8 sw=4 sts=4 et filetype=sh

check() {
    [[ "$mount_needs" ]] && return 1
    [ -f /etc/slackware-version ]
}

depends() {
    return 0
}

install() {
    local _line
    local _dracut_slk_version
    if [ -e "$moddir/dracut-version" ]; then
        _dracut_slk_version=$(cat "$moddir/dracut-version")
        inst "$moddir/dracut-version" /lib/dracut/$_dracut_slk_version
    fi
    inst_hook cmdline 01 "$moddir/version.sh"

}

