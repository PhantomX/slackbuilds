/* qconfig.h */
/* This file is here to prevent a file conflict on multiarch systems.  A
 * conflict will occur because qconfig.h has arch-specific definitions.
 *
 * DO NOT INCLUDE THE NEW FILE DIRECTLY -- ALWAYS INCLUDE THIS ONE INSTEAD. */

#if defined(__x86_64__)
# include <QtCore/qconfig-x86_64.h>
#elif defined(__i386__)
# include <QtCore/qconfig-i386.h>
#elif defined(__powerpc64__)
# include <QtCore/qconfig-ppc64.h>
#elif defined(__powerpc__)
# include <QtCore/qconfig-ppc.h>
#elif defined(__s390x__)
# include <QtCore/qconfig-s390x.h>
#elif defined(__s390__)
# include <QtCore/qconfig-s390.h> 
#elif defined(__sparc__) && defined (__arch64__)
# include <QtCore/qconfig-sparc64.h>
#elif defined(__sparc__)
# include <QtCore/qconfig-sparc.h>
#else
/* Should never reach this point, if so see bugzilla.redhat.com/223663 */
#error "This qt4-devel package does not work your architecture?"
#endif

