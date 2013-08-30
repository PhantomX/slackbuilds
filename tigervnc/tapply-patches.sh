
set -e -o pipefail

SB_PATCHDIR=${CWD}/tpatches

# patch -p1 -E --backup -z .cookie --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .cookie --verbose -i ${SB_PATCHDIR}/tigervnc-cookie.patch
patch -p1 -E --backup -z .ldnow --verbose -i ${SB_PATCHDIR}/${NAME}11-ldnow.patch
patch -p1 -E --backup -z .gethomedir --verbose -i ${SB_PATCHDIR}/${NAME}11-gethomedir.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}11-rh692048.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-inetd-nowait.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-setcursor-crash.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-manpages.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-key_is_down.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-getmaster.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-shebang.patch

set +e +o pipefail
