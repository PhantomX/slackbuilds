
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p1 --verbose --backup -i ${SB_PATCHDIR}/${NAME}.patch

sed -i -e '/^.*dlopen-pcre.*/d' debian/patches/series
for i in $(<debian/patches/series); do
  patch -p1 --verbose --backup --suffix=".pdeb" -i debian/patches/${i}
done

# Speedups DFA UTF-8 period patterns.
# original name: 0001-dfa-optimize-UTF-8-period.patch
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/grep-2.6.3-dfa-optimize-period.patch
# Speedups MBCSET ([a-z]) UTF-8 patterns.
# original name: 0002-fall-back-to-glibc-matcher-if-a-MBCSET-is-found.patch
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/grep-2.6.3-glibc-matcher-fallback.patch
# Speedups -m and removes quadratic complexity when going to glibc.
# 0004-dfa-convert-to-wide-character-line-by-line.patch
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/grep-2.6.3-dfa-convert-to-wide-char.patch
# Speedups DFA [[:digit:]] and [[:xdigit:]] patterns.
# 0005-dfa-speed-up-digit-and-xdigit.patch
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/grep-2.6.3-dfa-speedup-digit-xdigit.patch

set +e +o pipefail
