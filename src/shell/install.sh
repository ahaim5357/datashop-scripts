#!/usr/bin/env bash

DATASHOP_SCRIPTS_DIR='/usr/local/datashop'

set -e

# Check if script exists and move it
if [ -f datashop ]; then
    mkdir -p "$DATASHOP_SCRIPTS_DIR"
    cp datashop "${DATASHOP_SCRIPTS_DIR}/datashop"

    # Set ownership and execution of copied file
    chmod +x "${DATASHOP_SCRIPTS_DIR}/datashop"
    chown -R `id -u`:`id -g` "$DATASHOP_SCRIPTS_DIR"
fi

echo "Done!"
