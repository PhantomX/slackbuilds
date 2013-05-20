
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## Slackware
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.d_termname.envterm.buffersizeincrease.diff
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.crypt.diff
## Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.0.3-libs.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.0.3-screenrc.patch
# Some tweaks of the default screenrc
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.0.3-configh.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.0.3-stropts.patch
# Fixes potential buffer overflow when > 2^31 semicolons are passed.
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.0.1-args.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.0.2-maxstr.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.0.3-ipv6.patch
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.0.3-resize.patch
patch -p2 -E --backup -z .cc --verbose -i ${SB_PATCHDIR}/${NAME}-4.0.3-cc.patch
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-E3.patch


set +e +o pipefail
