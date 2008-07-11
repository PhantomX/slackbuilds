#!/bin/sh

# Required for Session Management
OPERA_SCRIPT_PATH=/usr/bin/opera
export OPERA_SCRIPT_PATH

# Location of the Opera binaries
OPERA_BINARYDIR=/usr/lib/opera/_OPVERSION
export OPERA_BINARYDIR

# Parse commandline parameters
toset=
_QTSTYLE_FROM_CMDLINE_='NO'
for arg
do
  if test "${toset}"
  then
      eval ${toset}="${arg}"
      export ${toset}
      toset=
  else
      case ${arg} in
          --binarydir*|-binarydir*) toset=OPERA_BINARYDIR ;;
          --personaldir*|-personaldir*|--pd*|-pd*) toset=OPERA_PERSONALDIR ;;
          -style)
              _QTSTYLE_FROM_CMDLINE_='YES'
              ;;
      esac
  fi
done
test -z "${toset}" || die Missing parameter for ${arg}

test "${_QTSTYLE_FROM_CMDLINE_}" = 'NO' && test -f "${HOME}/.qt/qtrc" && _OPERA_QTSTYLE=$(sed -n 's/^style=//p' ${HOME}/.qt/qtrc) && test "${_OPERA_QTSTYLE}" && set -- "$@" -style "${_OPERA_QTSTYLE}"


# Add ending path divider "/" if missing, so execution won't fail
if test $(echo ${OPERA_BINARYDIR} | sed -e 's/.*[^\/]$/NO/') = 'NO'; then
OPERA_BINARYDIR="${OPERA_BINARYDIR}/"
fi
if test ! -f ${OPERA_BINARYDIR}opera; then
    echo "The Opera binary is not located at \"${OPERA_BINARYDIR}opera\"."
    echo "Please modify the wrapper script at \"${0}\"."
    exit 1
elif test ! -x "${OPERA_BINARYDIR}opera"; then
    echo "You do not have execute rights on \"${OPERA_BINARYDIR}opera\", please ask the sysadmin to chmod +x it."
    exit 1
fi

# Opera enviroment
if test "${OPERA_DIR}" = '' ; then
  if test -d /usr/share/opera ; then
    OPERA_DIR=/usr/share/opera
  else
    echo "OPERA_DIR unset and not found at expected location (/usr/share/opera)"
    exit 1
  fi
fi

OPERA_LD_PRELOAD="${LD_PRELOAD}"
export OPERA_LD_PRELOAD

# Native Java enviroment
for d in "${OPERA_PERSONALDIR}" "${HOME}/.opera"
do if test -f "${d}/javapath.txt"
   then
      INIJAVA=$(cat "$d/javapath.txt")
      test -f "${INIJAVA}/libjava.so" || continue
      OPERA_JAVA_DIR="${INIJAVA}"
      break
   fi
done

if test ! "${OPERA_JAVA_DIR}"
then for j in lib jre/lib
     do d="${JAVA_HOME}/${j}/i386"
        test -f "${d}/libjava.so" || continue
	OPERA_JAVA_DIR="${d}"
	break
     done
fi

if test ! "${OPERA_JAVA_DIR}"
then
    PREFIXES="
	/usr
	/usr/java
	/usr/lib
	/usr/local
	/opt"

    for SUNJAVA in \
	java-6-sun \
	java-6-sun-1.6.0.00 \
	java-1.5.0-sun \
	java-1.5.0-sun-1.5.0.09 \
	java-1.5.0-sun-1.5.0.09/jre \
	java-1.5.0-sun-1.5.0.08 \
	java-1.5.0-sun-1.5.0.08/jre \
	java-1.5.0-sun-1.5.0.07 \
	java-1.5.0-sun-1.5.0.07/jre \
	java-1.5.0-sun-1.5.0.06 \
	java-1.5.0-sun-1.5.0.06/jre \
	jre1.5.0_06 \
	jdk1.5.0_06/jre \
	java-1.5.0-sun-1.5.0.05 \
	java-1.5.0-sun-1.5.0.05/jre \
	jre1.5.0_05 \
	jdk1.5.0_05/jre \
	java-1.5.0-sun-1.5.0.04 \
	java-1.5.0-sun-1.5.0.04/jre \
	jre1.5.0_04 \
	jdk1.5.0_04/jre \
	jre1.5.0_03 \
	jdk1.5.0_03/jre \
	jre1.5.0_02 \
	jdk1.5.0_02/jre \
	jre1.5.0_01 \
	jdk1.5.0_01/jre \
	jdk1.5.0/jre \
	j2re1.4.2_06 \
	j2sdk1.4.2_06/jre \
	j2re1.4.2_04 \
	j2sdk1.4.2_04/jre \
	j2re1.4.2_03 \
	j2sdk1.4.2_03/jre \
	j2re1.4.2_02 \
	j2sdk1.4.2_02/jre \
	j2re1.4.2_01 \
	j2sdk1.4.2_01/jre \
	j2re1.4.2 \
	j2sdk1.4.2/jre \
	j2re1.4.1_01 \
	j2re1.4.1 \
	SUNJava2-1.4.1 \
	BlackdownJava2-1.4.1/jre \
	j2re1.4.0_01 \
	j2sdk1.4.0_01/jre \
	j2re1.4.0 \
	jre1.4.0 \
	j2se/1.4/jre \
	j2se/1.3/jre \
	j2se/jre \
	jre1.3.1_15 \
	jre1.3.1_04 \
	jre1.3.1_02 \
	jre1.3.1_01 \
	j2re1.3.1 \
	jre1.3.1 \
	j2re1.3 \
	j2se/1.3/jre \
	SunJava2-1.3/jre \
	java2re \
	jdk1.2.2/jre \
	jdk1.2/jre \
	jre \
	java \
	; do
	for PREFIX in ${PREFIXES}
	do d="${PREFIX}/${SUNJAVA}/lib/i386"
	   test -f "${d}/libjava.so" || continue
	   OPERA_JAVA_DIR="${d}"
	   break
	done
	if test "${OPERA_JAVA_DIR}"; then break; fi
    done
    if test ! "${OPERA_JAVA_DIR}"; then
	for IBMJAVA in \
	    IBMJava2-142/jre \
	    IBMJava2-141/jre \
	    IBMJava2-14/jre \
	    IBMJava2-131/jre \
	    ; do
	    for PREFIX in ${PREFIXES}; do
		if test -f "${PREFIX}/${IBMJAVA}/bin/libjava.so"; then OPERA_JAVA_DIR="${PREFIX}/${IBMJAVA}/bin" && break; fi
	    done
	if test "${OPERA_JAVA_DIR}"; then break; fi
	done
    fi
fi

if test "${OPERA_JAVA_DIR}"; then
    LD_LIBRARY_PATH="${OPERA_JAVA_DIR}:${OPERA_JAVA_DIR}/native_threads:${OPERA_JAVA_DIR}/client:${OPERA_JAVA_DIR}/classic${LD_LIBRARY_PATH:+:}${LD_LIBRARY_PATH}"
    export LD_LIBRARY_PATH OPERA_JAVA_DIR
fi

# Workarounds for the "preloaded libXt" problem.
LD_PRELOAD="libjvm.so:libawt.so:${OPERA_LD_PRELOAD}"
export LD_PRELOAD
# To disable the first workaround, comment the next line.
JAVA_WORKAROUND=$(${OPERA_BINARYDIR}/works 2>/dev/null)

if test "${JAVA_WORKAROUND}" = 'works'; then
    OPERA_FORCE_JAVA_ENABLED="1"
else
    LD_PRELOAD="libjava.so:${LD_PRELOAD}"
    # To disable the second workaround, comment the next line.
    IBMJAVA131_WORKAROUND=$(${OPERA_BINARYDIR}/works 2>/dev/null)
    if test "${IBMJAVA131_WORKAROUND}" = 'works'; then
	OPERA_FORCE_JAVA_ENABLED="1"
    else
	LD_PRELOAD="${OPERA_LD_PRELOAD}"
    fi
fi
export LD_PRELOAD OPERA_FORCE_JAVA_ENABLED

# Acrobat Reader
for BINDIR in \
    /usr/local/Acrobat[45]/bin \
    /usr/lib/Acrobat[45]/bin \
    /usr/X11R6/lib/Acrobat[45]/bin \
    /opt/Acrobat[45]/bin \
    /usr/Acrobat[45]/bin \
    ; do
    if test -d ${BINDIR} ; then PATH=${PATH}:${BINDIR}; fi
done

# Exporting the enviroment
export OPERA_DIR PATH

LD_LIBRARY_PATH="${OPERA_BINARYDIR}${LD_LIBRARY_PATH:+:}${LD_LIBRARY_PATH}"
export LD_LIBRARY_PATH

# Spellchecker needs to find libaspell.so.15
for LIBASPELL_DIR in \
    /usr/local/lib \
    /usr/lib \
    /opkg/lib \
; do
    if test -f "${LIBASPELL_DIR}/libaspell.so.15"; then
        LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${LIBASPELL_DIR}"
    fi
done

# Running Opera
exec "${OPERA_BINARYDIR}opera" "$@"
