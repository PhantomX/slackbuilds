#!/bin/sh
if [ -x /usr/bin/seahorse-agent ]; then
    export `/usr/bin/seahorse-agent --variables`
fi
