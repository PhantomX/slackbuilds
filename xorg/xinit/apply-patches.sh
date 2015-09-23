
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xinit-1.0.2-client-session.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-startx-Pass-nolisten-tcp-by-default.patch
# A few fixes submitted upstream, rhbz#1177513, rhbz#1203780
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-startx-Pass-keeptty-when-telling-the-server-to-start.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-startx-Fix-startx-picking-an-already-used-display-nu.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-startx-Make-startx-auto-display-select-work-with-per.patch
# Fedora specific patch to match the similar patch in the xserver
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xinit-1.3.4-set-XORG_RUN_AS_USER_OK.patch

### Arch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/06_move_serverauthfile_into_tmp.diff
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fs25361.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fs46369.patch
  
set +e +o pipefail
