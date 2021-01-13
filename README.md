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
    -e AWS_SESSION_TOKEN \
    infoblox/helm:2.14.3-1e1c033 version --client
    Client: &version.Version{SemVer:"v2.14.3", GitCommit:"0e7f3b6637f7af8fcfddb3d2941fcc7cbebb0085", GitTreeState:"clean"}


Note:`AWS_SESSION_TOKEN` is needed if MFA is used for AWS authentication.
