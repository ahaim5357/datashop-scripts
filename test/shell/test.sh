#!/usr/bin/env bash

set -e

# Import test library bundled with the devcontainer CLI
# See https://github.com/devcontainers/cli/blob/HEAD/docs/features/test.md#dev-container-features-test-lib
# Provides the 'check' and 'reportResults' commands.
source dev-container-features-test-lib

# Run Feature Scenarios
check 'Get Project Metadata' datashop -u https://pslc-qa.andrew.cmu.edu/datashop /datasets/1142

# Report results on completion
reportResults
