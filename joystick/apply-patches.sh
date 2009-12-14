  
SB_PATCHDIR=${CWD}/patches

if [ "${SNAPBUILD}" = "YES" ] ;then
  zcat ${CWD}/${PSRCARCHIVE} | patch -p1 --verbose || exit 1
  for patch in \
    jitter-tolerance \
    button-axis-remapping \
    usb-joystick-segfault-fix \
    remap-calibration \
    button-map-segfault-fix \
    ioctl-error-handling \
  ; do
    cat debian/patches/${patch}.patch | patch -p2 -E --backup --verbose || exit 1
  done
else
  zcat ${SB_PATCHDIR}/${NAME}-1.2.15-redhat.patch.gz | patch -p1 -E --backup --verbose || exit 1
  zcat ${SB_PATCHDIR}/${NAME}-1.2.15-newkernel.patch.gz | patch -p1 -E --backup --verbose || exit 1
fi
