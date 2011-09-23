
SB_PATCHDIR=${CWD}/patches

set -e -o pipefail

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/kdebase.patch 
zcat ${SB_PATCHDIR}/kdebase-4.1.80-nsplugins-paths.patch.gz | patch -p2 -E --backup --verbose
zcat ${SB_PATCHDIR}/kdebase-4.2.1-home-icon-slk.patch.gz | patch -p2 -E --backup --verbose

# fix disabling automatic spell checking in the Konqueror UI (kde#228593)
zcat ${SB_PATCHDIR}/kdebase-4.4.0-konqueror-kde\#228593.patch.gz | patch -p2 -E --backup --verbose

# Password & User account becomes non responding
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/kdebase-4.3.4-bz\#609039-chfn-parse.patch

## upstream patches
# http://quickgit.kde.org/?p=kde-baseapps.git&a=commit&h=1a284bb79e547f0789f02b202fa309823e6198b5
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.7.1-kdebug270414.patch

# Mandriva

#trunk patches

set +e +o pipefail
