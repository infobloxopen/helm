## Helm2 Users

Helm2 was EOL in 2020. The stable repo bucket used by default in helm2 has also been deleted from Google. You will need to switch to the helm3 image or customize your helm2 deployments to avoid `helm repo` commands. The following error is encountered when helm2 attempts to sync helm repositories.

    docker run -e NOAWS=nope infoblox/helm:3.9.4-3e054b7 repo update
    Hang tight while we grab the latest from your chart repositories...
    ...Skip local chart repository
    ...Unable to get an update from the "stable" chart repository (https://kubernetes-charts.storage.googleapis.com):
            Failed to fetch https://kubernetes-charts.storage.googleapis.com/index.yaml : 403 Forbidden
    Update Complete.

Docker image with s3 plugin installed.

For usage see: https://hub.docker.com/r/alpine/helm

Add the following arguments to the docker run commands for usage of the s3 plugin:

Recommended way to execute this container

    -> % AWS_REGION=$(aws configure get region) \
    AWS_SECRET_ACCESS_KEY=$(aws configure get aws_secret_access_key) \
    AWS_ACCESS_KEY_ID=$(aws configure get aws_access_key_id) \
    AWS_SESSION_TOKEN=$(aws configure get aws_session_token) \
    docker run -it
    -e AWS_REGION \
    -e AWS_SECRET_ACCESS_KEY \
    -e AWS_ACCESS_KEY_ID \
    infoblox/helm:3.9.4-3e054b7 version --client
    Client: &version.Version{SemVer:"v2.14.3", GitCommit:"0e7f3b6637f7af8fcfddb3d2941fcc7cbebb0085", GitTreeState:"clean"}

Disable AWS calls while using this container

    -> % docker run -e NOAWS=nope infoblox/helm:3.9.4-3e054b7 repo ls
    Error: no repositories to show

Note:`AWS_SESSION_TOKEN` is needed if MFA is used for AWS authentication.
