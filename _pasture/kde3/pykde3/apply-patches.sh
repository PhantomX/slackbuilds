  
SB_PATCHDIR=${CWD}/patches

# http://mats.imk.fraunhofer.de/pipermail/pykde/2006-November/014627.html
zcat ${SB_PATCHDIR}/${PNAME}-3.16.0-kmimetype.patch.gz | patch -p1 -E --backup --verbose || exit 1
