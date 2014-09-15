
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

unset PATCH_VERBOSE_OPT
[ "${PATCH_VERBOSE}" = "YES" ] && PATCH_VERBOSE_OPT="--verbose"
[ "${PATCH_SVERBOSE}" = "YES" ] && set -o xtrace

PATCHCOM="patch -p1 -s -F1 --backup ${PATCH_VERBOSE_OPT}"

ApplyPatch() {
  local patch=$1
  shift
  if [ ! -f ${SB_PATCHDIR}/${patch} ]; then
    exit 1
  fi
  echo "Applying ${patch}"
  case "${patch}" in
  *.bz2) bzcat "${SB_PATCHDIR}/${patch}" | ${PATCHCOM} ${1+"$@"} ;;
  *.gz) zcat "${SB_PATCHDIR}/${patch}" | ${PATCHCOM} ${1+"$@"} ;;
  *) ${PATCHCOM} ${1+"$@"} -i "${SB_PATCHDIR}/${patch}" ;;
  esac
}

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
ApplyPatch ${NAME}-pt_BR-fix.patch
# Ubuntu
ApplyPatch new_release_check.patch

# Assorted fixes from upstream
ApplyPatch 0001-2238-Scheduler-Fix-undefined-this.scheduleCells.patch
ApplyPatch 0002-Fix-to-mitigate-fastresume-corruption.patch
ApplyPatch 0003-1126-2322-Emit-FinishedEvent-after-moving-storage-co.patch
ApplyPatch 0004-Extractor-Add-webui-page.patch
ApplyPatch 0005-1032-Keep-track-of-torrent-errors-over-restarts.patch
ApplyPatch 0006-1290-Execute-Add-TorrentRemoved-event.patch
ApplyPatch 0007-2470-Console-Fix-console-parsing-args.patch
ApplyPatch 0008-2478-Blocklist-Add-WebUI-plugin-page.patch
ApplyPatch 0009-Bump-version-for-updated-plugins.patch
ApplyPatch 0010-WebUI-Update-from-config-upon-showing-plugin-page.patch
ApplyPatch 0011-Backport-decode_string-from-develop.patch
ApplyPatch 0012-GTKUI-Optimized-the-updating-of-the-torrent-view.patch
ApplyPatch 0013-GTKUI-Suppress-unimportant-gnome-warnings.patch
ApplyPatch 0014-GTKUI-Fix-showing-the-open_folder-menuitem.patch
ApplyPatch 0015-LP-1168858-Nautilus-window-opens-behind-current-wind.patch
ApplyPatch 0016-Fix-for-Indicator-icon-label-issue.patch
ApplyPatch 0017-Fix-firing-of-Finished-event-when-moving.patch
ApplyPatch 0018-1310-Notifications-Add-webui-prefs-page.patch
ApplyPatch 0019-Notifications-Small-layout-fixes-for-web-page-and-ve.patch
ApplyPatch 0020-2493-GTKUI-Fix-TypeError-if-active-workspace-is-None.patch
ApplyPatch 0021-GTKUI-Fix-listview-error-with-new-config.patch
ApplyPatch 0022-2496-GTKUI-Fix-updating-core_config-before-setting-d.patch
ApplyPatch 0023-Revert-Fix-2221-Addtorrentdialog-KeyError-accessing-.patch
ApplyPatch 0024-2497-GTKUI-Fix-the-queue-Clear-button-not-properly-c.patch

set +e +o pipefail
