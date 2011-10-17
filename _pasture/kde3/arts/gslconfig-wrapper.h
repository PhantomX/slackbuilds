/* This file is here to prevent a file conflict on multiarch systems.  A
 * conflict will occur because apr.h has arch-specific definitions.
 *
 * DO NOT INCLUDE THE NEW FILE DIRECTLY -- ALWAYS INCLUDE THIS ONE INSTEAD. */

#if defined(__x86_64__)
#include "gslconfig-x86_64.h"
#elif defined(__i386__)
#include "gslconfig-i386.h"
#elif defined(__powerpc64__)
#include "gslconfig-ppc64.h"
#elif defined(__powerpc__)
#include "gslconfig-ppc.h"
#elif defined(__s390x__)
#include "gslconfig-s390x.h"
#elif defined(__s390__)
#include "gslconfig-s390.h"
#elif defined(__sparc__) && defined (__arch64__)
#include "gslconfig-sparc64.h"
#elif defined(__sparc__)
#include "gslconfig-sparc.h"
#else
#error "This arts-devel package does not work your architecture?"
#endif
