#!/bin/bash
#
# Import a given src.rpm on a given branch
# Licensed under the new-BSD license (http://www.opensource.org/licenses/bsd-license.php)
# Copyright (C) 2004-2005 Red Hat, Inc.
# Copyright (C) 2005 Fedora Foundation
#
# $Id: cvs-import.sh,v 1.33 2008/08/24 21:50:55 ausil Exp $

shopt -s nocasematch

# Initial setup
CVSTREE=${CVSTREE:=extras}
TOPLEVEL=${TOPLEVEL:=rpms}

# Check that we're being run from a good location
MYDIR=$(dirname $0)
if [ ! -f ${MYDIR}/CVS/Root ] ; then
    echo "ERROR: You need to run this script from the 'common' checkout" >&2
    exit 1
fi
if [ ! -f ${HOME}/.fedora.cert ]; then
    echo "ERROR: You need to download your Fedora client-side certificate" >&2
    echo "       from https://admin.fedoraproject.org/accounts/" >&2
    echo "       and save it in a file named ~/.fedora.cert" >&2
    exit 1
fi

# Check that the ssl certificate is not already expired or expiring in the
# next 10 minutes
OPENSSL=$(which openssl 2>/dev/null)
if [ -x ${OPENSSL} ]; then
    ${OPENSSL} x509 -checkend 6000 -noout -in ${HOME}/.fedora.cert
    if [ $? -ne 0 ]; then
        echo "ERROR: Your Fedora client-side certificate expired." >&2
        echo "       You need to download a new client-side certificate" >&2
        echo "       from https://admin.fedoraproject.org/accounts/" >&2
	echo "       and save it in a file named ~/.fedora.cert" >&2
        exit 1
    fi
fi

# use the CVSROOT from the checkout
CVSROOT=$(cat ${MYDIR}/CVS/Root)

# We need a writable directory for temporary checkouts and CVS work
WORKDIR="/tmp"
if test -w $(pwd) ; then
    WORKDIR="$(pwd)"
fi

[ -f branch ] && BRANCH=$(cat branch)

# short usage help
Usage() {
    cat <<EOF
Usage:

    $0 [-b <branch>] [-m <message>] <package>

Imports a package into the cvs repository. Will use the following defaults:
CVSROOT    = $CVSROOT
BRANCH     = ${BRANCH:-devel}

The package can also be imported on a PRE-EXISTING branch using the 
"-b BRANCH" flag. This script can not create new branches for you.
EOF
    exit 1
}

# Parse arguments
MESSAGE=
while [ -n "$1" ] ; do
    case "$1" in 
	# import the package on the given branch. If the branch does
	# not exist, we will branch the HEAD and then we will perform
	# the import
	-b | --branch )
	    shift
	    BRANCH="$1"
	    if [ -z "$BRANCH" ] ; then
		echo "ERROR: --branch requires an argument"
		Usage
		exit -1
	    fi
	    # protect against moronisms
	    if [ "$BRANCH" = "HEAD" -o "$BRANCH" = "devel" ] ; then
		BRANCH=
	    fi
	    ;;

	-m | --message )
	    shift
	    MESSAGE="$1"
	    ;;

	# the always helpful help message
	-h | --help )
	    Usage
	    exit 0
	    ;;

	* )
	    if [ -n "$PACKAGE" ] ; then
		echo "ERROR: Only one package at a time, please" >&2
		echo "Already got request for $PACKAGE" >&2
		exit -1
	    fi
	    PACKAGE="$1"
	    if [ ! -e "$PACKAGE" ] ; then
		echo "ERROR: Package $PACKAGE does not exist"
		Usage
		exit -2
	    fi
	    NVR=$(rpm -qp --qf "%{NAME}-%{VERSION}-%{RELEASE}" $PACKAGE 2>/dev/null)
	    SRCRPM=$(rpm -qp --qf "%{SOURCERPM}" $PACKAGE 2>/dev/null)
	    if [ -z "$NVR" -o "$SRCRPM" != "(none)" ] ; then
		echo "ERROR: Package $PACKAGE does not look like a source RPM package"
		Usage
		exit -3
	    fi
	    # extract NAME VERSION RELEASE, like a 31337 h@x0r
	    RELEASE=${NVR##*-}
	    NAME=${NVR%%-$RELEASE}
	    VERSION=${NAME##*-}
	    NAME=${NAME%%-$VERSION}
	    ;;
    esac
    shift
done

if [ -z "$PACKAGE" ] ; then
    echo "RPM source package required for import"
    Usage
    exit 0
fi

# make sure the PACKAGE is an absolute path, as we'll be changing
# directories fairly often in this script
PACKAGE="$(cd $(dirname $PACKAGE) && pwd)/$(basename $PACKAGE)"

# all well
export CVSROOT
CVS="cvs -d $CVSROOT"

# Grab a temp dir    
TMPDIR=$(mktemp -d $WORKDIR/tmpcvsXXXXXX)
trap "rm -rf $TMPDIR" 0 9 15

# A cleanup function that can be called from random places
CleanUp() {
    if [ -n "$LOGFILE" ] ; then
	rm -f $LOGFILE
    fi
    cd ${WORKDIR}
    rm -rf $TMPDIR
    echo
}

CreateBranchMakefile() {
    cat >Makefile <<EOF
# Makefile for source rpm: $NAME
# \$Id\$
NAME := $NAME
SPECFILE = \$(firstword \$(wildcard *.spec))

define find-makefile-common
for d in common ../common ../../common ; do if [ -f \$\$d/Makefile.common ] ; then if [ -f \$\$d/CVS/Root -a -w \$\$/Makefile.common ] ; then cd \$\$d ; cvs -Q update ; fi ; echo "\$\$d/Makefile.common" ; break ; fi ; done
endef

MAKEFILE_COMMON := \$(shell \$(find-makefile-common))

ifeq (\$(MAKEFILE_COMMON),)
# attept a checkout
define checkout-makefile-common
test -f CVS/Root && { cvs -Q -d \$\$(cat CVS/Root) checkout common && echo "common/Makefile.common" ; } || { echo "ERROR: I can't figure out how to checkout the 'common' module." ; exit -1 ; } >&2
endef

MAKEFILE_COMMON := \$(shell \$(checkout-makefile-common))
endif

include \$(MAKEFILE_COMMON)
EOF
}

# Check out the existing module
cd $TMPDIR
echo "Checking out module: '$NAME'"
$CVS -Q checkout $NAME || { echo "ERROR: \"$NAME\" module does not exist in cvs."; exit 1; }

# this is our working directory
cd $NAME

[ -d ${BRANCH} ] || { echo "ERROR: \"$NAME/$BRANCH\" does not exist!"; exit 1; }

# check if we have imported this entry
TAG=$(echo "${NAME##[0-9]}-$VERSION-$RELEASE" | sed -e 's/[$,.:;@]/_/g')
LOG_ENTRY="$TAG:${BRANCH:-HEAD}:$(basename $PACKAGE)"
if [ -n "$(grep ""^$LOG_ENTRY"" ./${BRANCH}/import.log 2>/dev/null)" ] ; then
    echo "ERROR: $PACKAGE was already imported on branch ${BRANCH:-HEAD}"
    CleanUp
    exit -2
fi
# Check here as well because back in the old days we used to write it here
if [ -n "$(grep ""^$LOG_ENTRY"" ./import.log 2>/dev/null)" ] ; then
    echo "ERROR: $PACKAGE was already imported on branch ${BRANCH:-HEAD}"
    CleanUp
    exit -2
fi

# Now the real import job is starting up
BRANCH="${BRANCH:-devel}"

# Unpack the src.rpm
TMP2=$(mktemp -d tmpXXXXXX)
pushd $TMP2 >/dev/null
echo "Unpacking source package: $(basename $PACKAGE)..."
rpm2cpio $PACKAGE | cpio -id --quiet || {
    echo "This package appears to be corrupt."
    echo "Skipping import for: $PACKAGE"
    CleanUp
    exit -1
} >&2
popd >/dev/null

# grab a list of files from the src.rpm
FILES=$(rpm -qpl $PACKAGE 2>/dev/null)
    
# Remove the files that are no longer present
OLDFILES=$(find ${BRANCH} -maxdepth 1 -type f \
    -not -name branch \
    -not -name import.log \
    -not -name sources \
    -not -name Makefile \
    -not -name .cvsignore \
    -print )
for f in $OLDFILES ; do
    if [ ! -f "$TMP2/$(basename $f)" ] ; then
	cvs -Q delete -f $f
	echo "R $(basename $f)"
    fi
done

# Add the new files
>${BRANCH}/sources.new
>${BRANCH}/.cvsignore.new

# Now build a list of what needs to be uploaded
UPLOADFILES=
for _f in $FILES ; do
    # just to be sure. Who knows when rpm will start returning
    # pathnames in src.rpm queries
    f=$(basename ${_f})

    add_file="yes"
    file_md5=$(cd $TMP2 && md5sum $f)
    file_size=$(stat --format="%s" $TMP2/$f)

    # if the file exists or it is listed in the sources we don't add it
    if [ -f ${BRANCH}/$f ] ; then
	add_file="no"
	cmp -s $TMP2/$f ${BRANCH}/$f || echo "U $f"
    elif [ -n "$(grep ""$file_md5"" ${BRANCH}/sources 2>/dev/null)" ] ; then
	add_file="no"
	# keep it around...
	echo "$file_md5" >> ${BRANCH}/sources.new
	echo "$f" >> ${BRANCH}/.cvsignore.new
    fi
    # we catch changed patches this way...
    mv -f $TMP2/$f ${BRANCH}/$f
    # we need to add this file
    pushd ${BRANCH} >/dev/null
    if [ "$add_file" = "yes" ] ; then
	case $f in 
	    *.tar | *gz | *.bz2 | *.lzma | *.Z | *.zip | \
	    *.ttf | *.bin | *.tbz | *.tbz2 | *.pdf | *.rpm | \
	    *.jar | *.war | *.db | *.cpio | *.jisp | *.egg | *.gem )
		UPLOADFILES="$UPLOADFILES $f"
		if [ -n "$(grep $f sources 2>/dev/null)" ] ; then
		    # this file existed before with a different md5sum
		    echo "N $f"
		else
		    echo "L $f"
		fi
		;;
	    *)
		cvs -Q add -ko $f 
		echo "A $f"
		;;
	esac
    fi
    popd >/dev/null
done
# upload the tarballs
pushd ${BRANCH} >/dev/null
# Re-add the branch Makefile (during resurrection of dead packages).
if [ ! -f Makefile ] ; then
    CreateBranchMakefile
    cvs -Q add Makefile
fi
rm -f sources && mv sources.new sources
rm -f .cvsignore && mv .cvsignore.new .cvsignore
if [ -n "$UPLOADFILES" ] ; then
    make upload FILES="$UPLOADFILES" || {
	echo "ERROR: Uploading the source tarballs failed!"
	exit 9
    }
fi
popd >/dev/null

# We no longer need this
rm -rf $TMP2

# setup finished
[ -f ./${BRANCH}/import.log ] || $(touch ./${BRANCH}/import.log; cvs add ./${BRANCH}/import.log)
echo "$LOG_ENTRY:$(date +%s)" >> ./${BRANCH}/import.log

echo "======================================================================="
cvs -Q diff -u
echo "======================================================================="
echo "Please check the above cvs diff."
echo "If you want to make any changes before committing, please press Ctrl-C."
echo "Otherwise press Enter to proceed to commit." 
read

cvs -Q update && \
    echo "cvs commit..." && \
    cvs -Q commit ${MESSAGE:+-m "$MESSAGE"} && echo "Commit Complete" && \
    cd ${BRANCH} && make tag && echo "Tagging '${TAG}' complete."

# Clean up
CleanUp
