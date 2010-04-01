
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.3p1-skip-initial.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.2p1-vendor.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-4.3p1-fromto-remote.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.1p1-log-in-chroot.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-4.0p1-exit-deadlock.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.1p1-askpass-progress.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-4.3p2-askpass-grab-info.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.2p1-allow-ip-opts.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.1p1-scp-manpage.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.2p1-edns.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.4p1-pka.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.3p1-randclean.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.3p1-dso.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.4p1-staterr.patch

set +e +o pipefail
