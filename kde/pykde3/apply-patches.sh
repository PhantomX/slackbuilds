  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${PNAME}-3.16.0-konsolepart.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://mats.imk.fraunhofer.de/pipermail/pykde/2006-November/014627.html
zcat ${SB_PATCHDIR}/${PNAME}-3.16.0-kmimetype.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://mats.imk.fraunhofer.de/pipermail/pykde/2006-December/015025.html
#zcat ${SB_PATCHDIR}/${PNAME}-3.16.0-python25.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://www.riverbankcomputing.com/Downloads/PyKDE3/PyKDE-3.16.0-sip-4.7.patch
zcat ${SB_PATCHDIR}/${PNAME}-3.16.0-sip-4.7.patch.gz | patch -p1 -E --backup --verbose || exit 1
