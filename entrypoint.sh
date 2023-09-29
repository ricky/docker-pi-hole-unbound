#!/bin/bash

/etc/init.d/unbound start

exec /s6-init "$@"
