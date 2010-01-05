#!/bin/bash

# lspkg - Lists packages installed on Slackware
# version - 1.0
# Suggested usage: $ lspkg [package] [package1]
# Modified by Phantom X, based on script from Tdmsilvino
# copied from http://tdmsilvino.wordpress.com/2008/05/17/listando-pacotes-no-slackware/


cd /var/log/packages/ || exit 1
PKG_LIST=$(echo $* | sed s/" "/"* "/g | sed s/$/$"*"/ )

for PACKAGE in ${PKG_LIST} ; do
  if [ -e ${PACKAGE} ] ;
  then
    # If we don't do this, commands run later will take the '-' to be an option
    # and will destroy the package database.  Packages should not contain spaces
    # in them.  Normally this type of problem results from a command line typo.
    if [ "$(echo ${PACKAGE} | cut -b 1)" = "-" ]; then
      PACKAGE="malformed-package-name-detected"
    fi
    # Check for old style package name with one segment:
    if [ "$(echo ${PACKAGE} | cut -f 1 -d -)" = "$(echo ${PACKAGE} | cut -f 2 -d -)" ]; then
      echo ${PACKAGE}
    else # has more than one dash delimited segment
      # Count number of segments:
      INDEX=1
      while [ ! "$(echo ${PACKAGE} | cut -f $INDEX -d -)" = "" ]; do
        INDEX=$(expr $INDEX + 1)
      done
      INDEX=$(expr $INDEX - 1) # don't include the null value
      # If we don't have four segments, return the old-style (or out of spec) package name:
      if [ "$INDEX" = "2" -o "$INDEX" = "3" ]; then
        echo ${PACKAGE}
      else # we have four or more segments, so we'll consider this a new-style name:
        NAME=$(expr $INDEX - 3)
        NAME="$(echo ${PACKAGE} | cut -f 1-$NAME -d -)"
      fi
    fi
    VER=$(expr $INDEX - 2)
    VER="$(echo ${PACKAGE} | cut -f $VER -d -)"
    ARCH=$(expr $INDEX - 1)
    ARCH="$(echo ${PACKAGE} | cut -f $ARCH -d -)"
    BUILD="$(echo ${PACKAGE} | cut -f $INDEX -d -)"

    echo -e -n "Package: \e[1m${NAME}\e[0m - "
    echo -e -n  "version: \e[1m${VER}\e[0m - "
    echo -e -n "arch: \e[1m${ARCH}\e[0m - "
    echo -e "build: \e[1m${BUILD}\e[0m"
  else
    PKG_NOT_FOUND=$(echo ${PACKAGE} | tr -d "*")
    echo -e "The package \e[1m${PKG_NOT_FOUND} was not found\e[0m in your system."
  fi
done
