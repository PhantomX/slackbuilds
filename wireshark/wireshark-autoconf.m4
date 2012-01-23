dnl AM_PATH_WIRESHARK([MINIMUM-VERSION, [ACTION-IF-FOUND [, ACTION-IF-NOT-FOUND]]])
dnl Test for wireshark development files, and define WIRESHARK_CFLAGS,
dnl	WIRESHARK_LIBS and WIRESHARK_VERSION.
dnl
AC_DEFUN([AM_PATH_WIRESHARK],[ 
	AC_ARG_WITH(wireshark-prefix,
	    [  --with-wireshark-prefix=PFX  Prefix where wireshark libraries are installed (optional)],
	    wireshark_config_prefix="$withval", wireshark_config_prefix="")

	wireshark_found=no
	if test "$wireshark_config_prefix" != "" ; then
		AM_PATH_GLIB_2_0(,,,[gmodule])
		WIRESHARK_CFLAGS="-DWS_VAR_IMPORT=extern -DWS_MSVC_NORETURN= -I$wireshark_config_prefix/include/wireshark -I$wireshark_config_prefix/include/wireshark/epan -I/usr/include/wireshark -I/usr/include/wireshark/epan $GLIB_CFLAGS"
		WIRESHARK_LIBS="-L$wireshark_config_prefix/lib -lwireshark -lwiretap $GLIB_LIBS"
		wireshark_found=yes
	else
		PKG_PROG_PKG_CONFIG()
		PKG_CHECK_MODULES(WIRESHARK, wireshark, wireshark_found=yes)
	fi

	ac_save_CFLAGS="$CFLAGS"
	ac_save_CLIBS="$LIBS"
	CFLAGS="$CFLAGS $WIRESHARK_CFLAGS"
	LIBS="$WIRESHARK_LIBS $LIBS"
	min_wireshark_version=ifelse([$1], ,0.0.0,[$1])
	if test $wireshark_found = yes; then
		AC_MSG_CHECKING(for wireshark version >= $min_wireshark_version)
		wireshark_found=no
		AC_TRY_RUN([
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <gmodule.h>
#include <epan/packet.h>
#include <epan/prefs.h>

int 
main()

{
	int ws_major_version, ws_minor_version, ws_micro_version;
	int major, minor, micro;
	char **tmp_version;

	tmp_version = (char *) strdup("$min_wireshark_version");
	major = 0;
	minor = 0;
	micro = 0;
	sscanf(tmp_version, "%d.%d.%d", &major, &minor, &micro);
	free(tmp_version);
	tmp_version = (char *) epan_get_version();
	sscanf(tmp_version, "%d.%d.%d",
	    &ws_major_version, &ws_minor_version, &ws_micro_version);

	if (ws_major_version > major ||
	    (ws_major_version == major && ws_minor_version > minor) ||
	    (ws_major_version == major && ws_minor_version == minor &&
	    ws_micro_version >= micro))
		return 0;

	printf("\n*** An old version of wireshark (%d.%d.%d) was found.\n",
	    ws_major_version, ws_minor_version, ws_micro_version);
	printf("*** You need a version of wireshark not older than %d.%d.%d. ",
	    major, minor, micro);
	return 1;
}
		], wireshark_found=yes)
	fi

	if test "$wireshark_found" != no; then
		AC_LANG_PUSH(C)
		AC_LINK_IFELSE([AC_LANG_PROGRAM([
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <gmodule.h>
#include <epan/packet.h>
#include <epan/prefs.h>
], [puts(epan_get_version());])], [WIRESHARK_VERSION=`./conftest$ac_exeext`],
wireshark_found=no)
		
		AC_LANG_POP
	fi

	CFLAGS="$ac_save_CFLAGS"
	LIBS="$ac_save_LIBS"

	if test "$wireshark_found" != no; then
		AC_MSG_RESULT(yes)
		ifelse([$2],, :, [$2])     
	else
		AC_MSG_RESULT(no)
		WIRESHARK_CFLAGS=""
		WIRESHARK_LIBS=""
		WIRESHARK_VERSION=""
		ifelse([$3], , :, [$3])
	fi
	AC_SUBST(WIRESHARK_CFLAGS)
	AC_SUBST(WIRESHARK_LIBS)
	AC_SUBST(WIRESHARK_VERSION)
])
