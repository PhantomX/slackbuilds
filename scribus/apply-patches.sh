
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://bugzilla.redhat.com/show_bug.cgi?id=506074
# http://bugs.scribus.net/view.php?id=8232
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.7-system-hyphen.patch
# http://bugs.scribus.net/view.php?id=8917
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.7-menuicons.patch
# https://bugzilla.redhat.com/show_bug.cgi?id=604124
# http://bugs.scribus.net/view.php?id=9180
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.7-selecting-frame-crash.patch
# fix version variable for buildsystem
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.7-version.patch

set +e +o pipefail
