#!/bin/bash
set -eo pipefail

chmod 600 "${CONFIG_DIR}/gauth.csv"

exec "$@"
