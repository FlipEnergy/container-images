#!/bin/bash

if [ -z "$PORT" ]; then
  export PORT=8000
fi

if [ -z "$SERVER_ROOT" ]; then
  export SERVER_ROOT=http://localhost:${PORT}
fi

if [ -z "$DBTYPE" ]; then
  export DBTYPE=sqlite3
fi

if [ -z "$DBCONFIG" ]; then
  export DBCONFIG=/data/focalboard.db
fi

if [ -z "$POSTGRES_DBCONFIG" ]; then
  export POSTGRES_DBCONFIG='dbname=focalboard sslmode=disable'
fi

if [ -z "$USE_SSL" ]; then
  export USE_SSL=false
fi

if [ -z "$ENABLE_TELEMETRY" ]; then
  export ENABLE_TELEMETRY=true
fi

if [ -z "$SESSION_EXPIRE_TIME" ]; then
  export SESSION_EXPIRE_TIME=2592000
fi

if [ -z "$SESSION_REFRESH_TIME" ]; then
  export SESSION_REFRESH_TIME=18000
fi

echo "{
    \"serverRoot\": \"${SERVER_ROOT}\",
    \"port\": ${PORT},
    \"dbtype\": \"${DBTYPE}\",
    \"dbconfig\": \"${DBCONFIG}\",
    \"postgres_dbconfig\": \"${POSTGRES_DBCONFIG}\",
    \"useSSL\": ${USE_SSL},
    \"webpath\": \"/opt/focalboard/pack\",
    \"filespath\": \"./files\",
    \"telemetry\": ${ENABLE_TELEMETRY},
    \"session_expire_time\": ${SESSION_EXPIRE_TIME},
    \"session_refresh_time\": ${SESSION_REFRESH_TIME},
    \"localOnly\": false,
    \"enableLocalMode\": true,
    \"localModeSocketLocation\": \"/tmp/focalboard_local.socket\"
}" > /data/config.json

exec /opt/focalboard/bin/focalboard-server
