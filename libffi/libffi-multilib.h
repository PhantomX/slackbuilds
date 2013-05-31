/* This file is here to prevent a file conflict on multiarch systems. */
#ifdef @FILE@_wrapper_h
#error "Do not define @FILE@_wrapper_h!"
#endif
#define @FILE@_wrapper_h

#if defined(__i386__)
#include "@FILE@-i386.h"
#elif defined(__powerpc64__)
#include "@FILE@-ppc64.h"
#elif defined(__powerpc__)
#include "@FILE@-ppc.h"
#elif defined(__s390x__)
#include "@FILE@-s390x.h"
#elif defined(__s390__)
#include "@FILE@-s390.h"
#elif defined(__x86_64__)
#include "@FILE@-x86_64.h"
#else
#error "The libffi package is not usable with the architecture."
#endif

#undef @FILE@_wrapper_h
