
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# In one remaining place, make sure we check for string in the stdlib before we use our copy
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/paste-unbundle-stdlib.patch
rm -f paste/util/subprocess24.py
# Use a system version of python-tempita before our bundled copy
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/paste-unbundle-tempita.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/paste-27-lambda.patch

set +e +o pipefail
