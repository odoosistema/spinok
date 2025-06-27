#!/bin/bash

set -e

if [ -v PASSWORD_FILE ]; then
    PASSWORD="$(< $PASSWORD_FILE)"
fi

# set the postgres database host, port, user and password according to the environment
# and pass them as arguments to the odoo process if not present in the config file
: ${HOST:=${DB_PORT_5432_TCP_ADDR:='db'}}
: ${PORT:=${DB_PORT_5432_TCP_PORT:=5432}}
: ${USER:=${DB_ENV_POSTGRES_USER:=${POSTGRES_USER:='odoo'}}}
: ${PASSWORD:=${DB_ENV_POSTGRES_PASSWORD:=${POSTGRES_PASSWORD:='odoo'}}}

PSQL_ARGS=()
function check_psql_config() {
    param="$1"
    value="$2"
    PSQL_ARGS+=("--${param}")
    PSQL_ARGS+=("${value}")
}
DB_ARGS=()
function check_config() {
    param="$1"
    value="$2"
    if grep -q -E "^\s*\b${param}\b\s*=" "$ODOO_RC" ; then       
        value=$(grep -E "^\s*\b${param}\b\s*=" "$ODOO_RC" |cut -d " " -f3|sed 's/["\n\r]//g')
    fi;
    DB_ARGS+=("--${param}")
    DB_ARGS+=("${value}")
}
check_config "db_host" "$HOST"
check_config "db_port" "$PORT"
check_config "db_user" "$USER"
check_config "db_password" "$PASSWORD"

check_psql_config "host" "$HOST"
check_psql_config "port" "$PORT"
check_psql_config "username" "$USER"

case "$1" in
    pdb | dbg | debug | debugpy)
        shift
        wait-for-psql.py ${DB_ARGS[@]} --timeout=30
        exec python3 -m debugpy --listen 5678 "$ODOO_PATH/odoo-bin" "$@" "${DB_ARGS[@]}"
        ;;
    -- | odoo)
        shift
        if [[ "$1" == "scaffold" ]] ; then
            exec odoo-bin "$@"
        else
            wait-for-psql.py ${DB_ARGS[@]} --timeout=30
            exec odoo-bin "$@" "${DB_ARGS[@]}"
        fi
        ;;
    -*)
        wait-for-psql.py ${DB_ARGS[@]} --timeout=30
        exec odoo-bin "$@" "${DB_ARGS[@]}"
        ;;
    psql)
        shift
        exec env PGPASSWORD=${PASSWORD} psql "$@" "${PSQL_ARGS[@]}"
        ;;
    *)
        exec "$@"
esac

exit 1