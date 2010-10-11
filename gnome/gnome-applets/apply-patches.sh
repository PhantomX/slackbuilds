
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-2.10.1-use-builtin-apm.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.15.1.1-dont-require-display.patch.gz | patch -p1 -E --backup --verbose

# do the nullapplet dance for battstat
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-null-battstat.patch

if [ "${SB_GST}" != "YES" -a "${SB_GSTDEF}" != "YES" ] ;then
  # and keep the mixer hidden away from the add to panel dialog
  zcat ${SB_PATCHDIR}/gnome-applets-no-mixer-icon.patch.gz | patch -p1 -E --backup --verbose
fi

if [ "${SB_GSTP}" = "YES" ] ;then
  zcat ${SB_PATCHDIR}/gnome-applets-2.28.0-gstmixer-with-parallel.patch.gz | patch -p0 -E --backup --verbose
fi

# do the nullapplet dance for stickynotes
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/stickynotes-null.patch
# https://bugzilla.gnome.org/show_bug.cgi?id=609945
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gnome-applets-libs.patch

set +e +o pipefail
