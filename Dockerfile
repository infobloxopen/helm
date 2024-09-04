ARG HELM_VERSION=3

FROM alpine/helm:${HELM_VERSION}

#Install yq and jq dependencies
#FIXME: add versioning to helm-s3
RUN apk add --update --no-cache git bash && \
    helm plugin install https://github.com/hypnoglow/helm-s3.git && \
    helm plugin install https://github.com/chartmuseum/helm-push.git && \
    rm -f /var/cache/apk/*

# helm will create the following directories on start
# $HOME/.cache
# $HOME/.config
# $HOME/.local
RUN mkdir /root/.cache/helm/repository/
RUN chmod -R a+rwx $HOME

ADD entrypoint.sh /entrypoint.sh
ENV HOME=/root
WORKDIR /tmp
ENTRYPOINT ["/entrypoint.sh", "helm"]
CMD ["--help"]
