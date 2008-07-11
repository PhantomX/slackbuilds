echo "The password below is \"anoncvs\":"
cvs -z 9 -d :pserver:anoncvs@sources.redhat.com:/cvs/glibc login
cvs -z 9 -d :pserver:anoncvs@sources.redhat.com:/cvs/glibc co libc
