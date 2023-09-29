# Docker Pi-hole with Unbound

This is a repacking of the official
[Pi-Hole Docker image](https://github.com/pi-hole/docker-pi-hole) configured to
use a local instance of [Unbound](https://nlnetlabs.nl/projects/unbound/about/)
as the upstream DNS server.

See the [Pi-hole unbound documentation](https://docs.pi-hole.net/guides/dns/unbound/)
for more on what this is and why you might want to use it.

## Usage

### Initialization & Configuration

This repo comes with a [`docker-compose.yml` template](docker-compose.yml.tmpl).
You can either copy it to `docker-compose.yml` and edit it by hand or use the
included [initialization script](initialize.sh).

In either case, it is recommended that you `cp dotenv.example .env` and customize
it for your local network and preferences.

The docker image and services will be prefixed with `${PWD}_`. You may want to
set the [`COMPOSE_PROJECT_NAME` environment variable](https://docs.docker.com/compose/reference/envvars/#compose_project_name)
or checkout this repo with a shorter directory name. e.g.:

```shell
$ git checkout https://github.com/ricky/docker-pi-hole-unbound.git pihole
```

#### Network configuration

The default configuration assigns the container its own unique IP using a
[`macvlan` network](https://docs.docker.com/network/macvlan/) in 801.2q trunk
bridge mode. If you prefer a different configuration (or lack kernel support for
801.2q bridges), manually edit the `networks` section of `docker-compose.yml`.

See the [official Compose documentation](https://docs.docker.com/compose/networking/)
for more options.


### Running

```shell
# Remove the -d flag to run in the foreground
$ docker-compose up -d
```

### Building

By default, this image will be based on `pihole/pihole:latest`. A different
[tag](https://github.com/pi-hole/docker-pi-hole/releases) can be specified using
the `PIHOLE_BASE_VERSION` environment variable or by overriding
`services.pihole.build.args.PIHOLE_BASE_VERSION` in `docker-compose.yml`.

e.g.:

`$ PIHOLE_BASE_VERSION=2022.08.2 docker-compose build`

### Upgrading

To upgrade to a new [docker-pi-hole release](https://github.com/pi-hole/docker-pi-hole/releases),
you need to [rebuild the image](#building), bring the service down, and back up.

If you are using `pihole/pihole:latest`, you'll want to `pull` the most current
version before building.

```shell
$ docker pull pihole/pihole:latest
$ docker-compose build
$ docker-compose down && docker-compose up -d
```
