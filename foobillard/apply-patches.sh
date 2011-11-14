
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-3.0a-as-needed.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-snooker_reset.patch.gz | patch -p0 -E --backup --verbose

zcat ${CWD}/${PSRCARCHIVE} | patch -p1 -E --verbose
for patch in 03_bugfixes 04_manpage 05_foul_explanation 06_show_ball_to_hit ;do
  patch -p1 --backup --verbose -i debian/patches/${patch}
done

set +e +o pipefail
