#!/bin/bash

set -e

# helm requested, sync the infoblox s3 bucket
if [ -z "$NOAWS" ] && [ "$1" = 'helm' ] && [ "$2" != 'version' ] && [ "$2" != 'lint' ] && [ "$2" != 'template' ] && [ "$2" != 'package' ] && [ "$2" != 'dependency' ] && [ "$2" != 'dep' ];
then

    if ! helm repo list | grep 'infobloxcto[[:space:]]\+s3://infoblox-helm-dev/charts' > /dev/null
    then
        helm repo add infobloxcto s3://infoblox-helm-dev/charts >&2
    fi
    helm repo update >&2
fi

exec "$@"
