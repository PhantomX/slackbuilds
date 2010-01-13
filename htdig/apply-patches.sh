  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/htdig-3.1.5-rh.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Fix "common dir" location and add "synonym_dictionary" entry:
zcat ${SB_PATCHDIR}/htdig.conf.diff.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/htdig-3.2.0b4-xopen.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/htdig-3.2.0b5-overflow.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/htdig-3.2.0b6-robots.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/htdig-3.2.0b6-unescaped_output.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/htdig-3.2.0b6-compile-fix.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/htdig-3.2.0b6-opts.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/htdig-3.2.0b6-incremental.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/htdig-3.2-CVE-2007-6110.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/htdig-3.2.0b6-htstat-segv.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/htdig-3.2.0-external_parsers.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/htdig-3.2.0-allow_numbers.patch.gz | patch -p1 -E --backup --verbose || exit 1
