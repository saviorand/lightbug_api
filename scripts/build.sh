#!/bin/bash
set -e

# The environment to build the package for. Defaults to "default" if not provided.
ENVIRONMENT="${1:-default}"

if [[ "${ENVIRONMENT}" == "--help" ]]; then
    echo "Usage: ENVIRONMENT - Argument 1 corresponds with the environment you wish to build the package for."
    exit 0
fi

echo "Building for environment: ${ENVIRONMENT}"

magic run template -m "${ENVIRONMENT}"
magic run rattler-build build -r recipes -c https://conda.modular.com/max -c conda-forge --skip-existing=all
