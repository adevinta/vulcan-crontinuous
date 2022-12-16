#!/bin/sh

# Copyright 2020 Adevinta

export PORT=${PORT:-8080}
export PATH_STYLE=${PATH_STYLE:-false}
export RANDOMIZE_CRON_MINUTE_INTERVAL=${RANDOMIZE_CRON_MINUTE_INTERVAL:-0}

# Apply env variables
cat config.toml | envsubst > run.toml

./vulcan-crontinuous -c run.toml
