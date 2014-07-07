
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pcre-8.21-multilib.patch
# Do no rely on wrapping signed integer while parsing {min,max} expression,
# bug rh#1086630, upstream bug #1463
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pcre-8.35-Do-not-rely-on-wrapping-signed-integer-while-parsein.patch
# Fix bad starting data when char with more than one other case follows
# circumflex in multiline UTF mode, bug rh#1110620, upstream bug #1492,
# in upstream after 8.35
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pcre-8.35-Fix-bad-starting-data-when-char-with-more-than-one-o.patch
# Fix not including VT in starting characters for \s if pcre_study() is used,
# bug rh#1111045, upstream bug #1493, in upstream after 8.35
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pcre-8.35-Fix-not-including-VT-in-starting-characters-for-s.patch
# Fix character class with a literal quotation, bug #1111054,
# upstream bug rh#1494, in upstream after 8.35
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pcre-8.35-Fix-bad-compile-of-Qx-.-where-x-is-any-character.patch


set +e +o pipefail
