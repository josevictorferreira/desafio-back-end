#!/bin/sh
set -e

# Remove a potentially pre-existing server.pid for Rails.

until PGPASSWORD=postgres psql -h db -U postgres -c '\q'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

rm -f /myapp/tmp/pids/server.pid

rake db:create
rake db:migrate

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"

