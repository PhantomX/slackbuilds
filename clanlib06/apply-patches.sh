
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/ClanLib-0.6.5-debian.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/ClanLib-0.6.5-suse.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/ClanLib-0.6.5-tolua++.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/ClanLib-0.6.5-smalljpg.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/ClanLib-0.6.5-gcc4.3.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/ClanLib-0.6.5-mikmod32.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/ClanLib-0.6.5-alsa.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/ClanLib-0.6.5-extra-keys.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/ClanLib-0.6.5-xev-keycodes.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/ClanLib-0.6.5-iterator-abuse.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ClanLib-0.6.5-gcc4.6.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ClanLib-0.6.5-gzopen-flags.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/ClanLib-0.6.5-libpng15.patch

set +e +o pipefail
