ARG ALPINE_TAG="3.10"
FROM alpine:${ALPINE_TAG}
RUN apk add --no-cache bind-tools curl nghttp2 openssl-dev bash netcat-openbsd ipvsadm
ENTRYPOINT ["/bin/sh", "-c"]
CMD ["echo runner"]
