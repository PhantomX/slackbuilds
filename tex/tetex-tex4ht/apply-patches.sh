
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

#patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${CWD}/${PSRCARCHIVE} | patch -p1 -E --backup --verbose 
for patch in $(<debian/patches/series) ;do
  patch -p1 -E --backup --verbose -i debian/patches/${patch}
done
for patch in $(<debian/lit/patches/series) ;do
  patch -p1 -E --backup --verbose -i debian/lit/patches/${patch}
done
chmod a+x debian/lit/rebuild.sh
( cd debian/images; for i in *.uue; do uudecode ${i}; done; mv *.png ../html)

set +e +o pipefail
