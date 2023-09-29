ARG PIHOLE_BASE_VERSION=latest
FROM pihole/pihole:$PIHOLE_BASE_VERSION

RUN apt update && apt upgrade -y && apt install -y unbound &&                   \
    apt clean && rm -rf /var/lib/apt/lists/*

ADD https://www.internic.net/domain/named.root /var/lib/unbound/root.hints
RUN chown unbound:unbound /var/lib/unbound/root.hints
COPY unbound.conf /etc/unbound/unbound.conf.d/pi-hole.conf

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
