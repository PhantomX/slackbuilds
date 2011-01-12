
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mozilla_words.patch
zcat ${SB_PATCHDIR}/en_GB-singleletters.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/en_GB.two_initial_caps.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/en_US-strippedabbrevs.patch.gz | patch -p1 -E --backup --verbose
#See https://sourceforge.net/tracker/?func=detail&aid=2987192&group_id=143754&atid=756397
#to allow "didn't" instead of suggesting change to typographical apostrophe
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-allow-non-typographical.marks.patch
#See https://bugzilla.redhat.com/show_bug.cgi?id=619577 add SI and IEC prefixes
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-SI_and_IEC.patch

set +e +o pipefail
