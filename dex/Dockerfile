FROM alpine:latest

COPY --from=quay.io/dexidp/dex:latest /usr/local/bin/dex /usr/local/bin/dex
COPY --from=quay.io/dexidp/dex:latest /web /web
WORKDIR /
ENTRYPOINT ["dex"]
CMD ["serve", "/dex-config/dex-server-config.yml"]
