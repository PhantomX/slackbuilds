
set -e -o pipefail

SB_PATCHDIR=${CWD}/tpatches

# patch -p1 -E --backup -z .cookie --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup -z .cookie --verbose -i ${SB_PATCHDIR}/tigervnc-cookie.patch
patch -p1 -E --backup -z .ldnow --verbose -i ${SB_PATCHDIR}/${NAME}11-ldnow.patch
patch -p1 -E --backup -z .gethomedir --verbose -i ${SB_PATCHDIR}/${NAME}-libvnc-os.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}11-rh692048.patch
patch -p1 -E --backup --verbose -d unix/xserver -i ${SB_PATCHDIR}/${NAME}-xserver116-rebased.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-inetd-nowait.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-manpages.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-getmaster.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-shebang.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-format-security.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-xstartup.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-xserver117.patch

set +e +o pipefail
