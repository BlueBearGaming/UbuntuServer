#!/usr/bin/env bash

set -euo pipefail

sudo sh -c "echo $(ip route|awk '/default/ { print $3 }') host.docker.internal >> /etc/hosts"

exec "$@"
