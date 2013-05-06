# This is a copy of the _filedir function in bash_completion, included
# and (re)defined separately here because some versions of Adobe
# Reader, if installed, are known to override this function with an
# incompatible version, causing various problems.
#
# https://bugzilla.redhat.com/677446
# http://forums.adobe.com/thread/745833

_filedir()
{
    local i IFS=$'\n' xspec

    _tilde "$cur" || return 0

    local -a toks
    local quoted x tmp

    _quote_readline_by_ref "$cur" quoted
    x=$( compgen -d -- "$quoted" ) &&
    while read -r tmp; do
        toks+=( "$tmp" )
    done <<< "$x"

    if [[ "$1" != -d ]]; then
        # Munge xspec to contain uppercase version too
        # http://thread.gmane.org/gmane.comp.shells.bash.bugs/15294/focus=15306
        xspec=${1:+"!*.@($1|${1^^})"}
        x=$( compgen -f -X "$xspec" -- $quoted ) &&
        while read -r tmp; do
            toks+=( "$tmp" )
        done <<< "$x"
    fi

    # If the filter failed to produce anything, try without it if configured to
    [[ -n ${COMP_FILEDIR_FALLBACK:-} && \
        -n "$1" && "$1" != -d && ${#toks[@]} -lt 1 ]] && \
        x=$( compgen -f -- $quoted ) &&
        while read -r tmp; do
            toks+=( "$tmp" )
        done <<< "$x"


    if [[ ${#toks[@]} -ne 0 ]]; then
        # 2>/dev/null for direct invocation, e.g. in the _filedir unit test
        compopt -o filenames 2>/dev/null
        COMPREPLY+=( "${toks[@]}" )
    fi
} # _filedir()
