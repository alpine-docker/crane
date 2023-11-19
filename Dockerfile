FROM alpine

ARG ARCH

# Ignore to update versions here
# docker build --no-cache --build-arg CRANE_VERSION=${crane_version} -t ${image}:${tag} .
ARG VERSION=v0.16.1
ARG OS=Linux

# Install crane (latest release)
# ENV BASE_URL="https://storage.googleapis.com/kubernetes-helm"
RUN case `uname -m` in \
    x86_64) ARCH=x86_64; ;; \
    armv7l) ARCH=arm64; ;; \
    aarch64) ARCH=arm64; ;; \
    ppc64le) ARCH=ppc64le; ;; \
    s390x) ARCH=s390x; ;; \
    *) echo "un-supported arch, exit ..."; exit 1; ;; \
    esac && \
    echo "export ARCH=$ARCH" > /envfile && \
    cat /envfile

RUN . /envfile && echo $ARCH && \
    apk add --update --no-cache curl ca-certificates bash git && \
    mkdir -p /tmp/crane && cd /tmp/crane && \
    curl -sL "https://github.com/google/go-containerregistry/releases/download/${VERSION}/go-containerregistry_${OS}_${ARCH}.tar.gz" |tar -xvz && \
    mv crane /usr/bin/crane && \
    chmod +x /usr/bin/crane && \
    cd /tmp && rm -rf crane

ENTRYPOINT ["/usr/bin/crane"]
CMD ["--help"]
