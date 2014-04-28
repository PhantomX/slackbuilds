#!/bin/bash

# runvdr - VDR launcher
#
# runvdr [VDROPTION]...

shopt -s nocasematch nullglob

VDR=/usr/sbin/vdr
PLUGINDIR=/usr/lib/vdr
PLUGINVER=VDR_PLUGIN_VERSION
PLUGINSUF=${PLUGINVER:+.$PLUGINVER}

plugconf()
{
    local plugin=$1 PLUGIN_OPTIONS= PLUGIN_ENABLED=
    if [[ -e /etc/default/vdr-plugins.d/$plugin.conf ]] ; then
        . /etc/default/vdr-plugins.d/$plugin.conf
        case $PLUGIN_ENABLED in no|false|0) return ;; esac
    fi
    if [[ $PLUGIN_OPTIONS ]] ; then
        VDR_OPTIONS+=( --plugin="$plugin $PLUGIN_OPTIONS" )
    else
        VDR_OPTIONS+=( --plugin=$plugin )
    fi
}

build_cmdline()
{
    local plugin= p=
    # Add "priority" plugins.
    for plugin in $VDR_PLUGIN_ORDER ; do
        [[ -e $PLUGINDIR/libvdr-${plugin}.so$PLUGINSUF ]] && plugconf $plugin
    done
    # Add the rest available.
    for plugin in $PLUGINDIR/libvdr-*.so$PLUGINSUF ; do
        plugin=${plugin##*/libvdr-}
        plugin=${plugin%.so$PLUGINSUF}
        for p in $VDR_PLUGIN_ORDER ; do
            if [[ $plugin == $p ]] ; then
                # Already added.
                continue 2
            fi
        done
        plugconf $plugin
    done
}

VDR_OPTIONS=()
[[ -f /etc/default/vdr ]] && . /etc/default/vdr
[[ $DAEMON_COREFILE_LIMIT ]] && \
    ulimit -S -c $DAEMON_COREFILE_LIMIT &>/dev/null && \
    VDR_OPTIONS+=( --userdump ) && cd ${TMPDIR:-/tmp}

build_cmdline

exec $VDR "$@" "${VDR_OPTIONS[@]}"
