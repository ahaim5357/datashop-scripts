#!/usr/bin/env bash

set -e

# Import test library bundled with the devcontainer CLI
# See https://github.com/devcontainers/cli/blob/HEAD/docs/features/test.md#dev-container-features-test-lib
# Provides the 'check' and 'reportResults' commands.
source dev-container-features-test-lib

# Public: Checks and validates the status code.
#
# Runs a command and determines whether the status code matches the
# one provided. If no status code is provided, then checks 0. If the
# provided status code is negative, the value is transformed into its
# positive, 8-bit counterpart.
#
# Parameters
#
# * -c | --status-code - The status code to check against.
# * $@                 - The command to run.
# 
# Examples
#
#     check_and_validate exit 0
#     check_and_validate -c 1 exit 1
#
# Returns 0 if the status code matches or 1 otherwise.
check_and_validate() {
    local status_code_to_validate=0
    local cmd=''

    # Read in arguments
    while true; do
        case "$1" in 
            -c | --status-code )
                # Set status code to compare against
                status_code_to_validate=$2
                shift 2
                ;;
            * )
                # Read command to check
                cmd="$@"
                break
                ;;
        esac
    done

    # Transform status code into positive number
    if [ $status_code_to_validate -lt 0 ]; then
        status_code_to_validate=$(($status_code_to_validate + 256))
    fi

    # Evaluate command and get status code
    eval "$cmd"
    local status_code=$?
    if [ $status_code -ne $status_code_to_validate ]; then
        printf "Error: %s\n- Expected Status Code: %s\n- Actual   Status Code: %s\n" \
            "$cmd" "$status_code_to_validate" "$status_code"
        return 1
    fi
    
    # Return success if no error
    return 0
}

# Run DataShop Queries
# See https://pslcdatashop.web.cmu.edu/api/DataShop%20Public%20API-v0.41.pdf

## 5   Authentication
check '5 Authentication - Bad Tokens' check_and_validate -c -100 datashop -i 'bad-key' -s 'bad-secret' -u https://pslc-qa.andrew.cmu.edu/datashop /datasets/1142

## 6.1 Getting Data: Get Dataset Metadata
check '6.1 Getting Data: Get Dataset Metadata' check_and_validate datashop -u https://pslc-qa.andrew.cmu.edu/datashop /datasets/1142
# TODO: Request Parameters, Path Variables, Error Tests

## 6.2 Getting Data: Get Project Metadata
check '6.2 Getting Data: Get Project Metadata' check_and_validate datashop -u https://pslc-qa.andrew.cmu.edu/datashop /datasets/projects/34
# TODO: Request Parameters, Path Variables, Error Tests

## 6.3 Getting Data: Get Sample Metadata
check '6.3 Getting Data: Get Sample Metadata' check_and_validate datashop -u https://pslc-qa.andrew.cmu.edu/datashop /datasets/1142/samples/4393
# TODO: Request Parameters, Path Variables, Error Tests

## 6.4 Getting Data: Get Transactions (TODO: FIX FAILURE)
# check '6.4 Getting Data: Get Transactions' check_and_validate datashop -u https://pslc-qa.andrew.cmu.edu/datashop /datasets/1142/samples/4393/transactions
# TODO: Request Parameters, Path Variables, Error Tests

## 6.5 Getting Data: Get Student-Step Records (TODO: FIX FAILURE)
# check '6.5 Getting Data: Get Student-Step Records' check_and_validate -c 3 datashop -u https://pslc-qa.andrew.cmu.edu/datashop /datasets/1142/samples/4393/steps
# TODO: Request Parameters, Path Variables, Error Tests

## 7.1 Create Project: Create a Project
# TODO

## 8.1 Create Dataset: Create a Dataset
# TODO

## 9.1 Attach File to Dataset: Add File
# TODO

## 10.1 External Analyses: Access and ownership
# TODO

## 10.2 External Analyses: Add External Analysis
# TODO

## 10.3 External Analyses: Get External Analyses Metadata
# TODO

## 10.4 External Analyses: Get External Analysis
# TODO

## 10.5 External Analyses: Delete External Analysis
# TODO

## 11.1 Custom Fields: Access and ownership
# TODO

## 11.2 Custom Fields: Data Types
# TODO

## 11.3 Custom Fields: Add Custom Field
# TODO

## 11.4 Custom Fields: Get Custom Field Metadata
# TODO

## 11.5 Custom Fields: Set Custom Field
# TODO

## 11.6 Custom Fields: Delete Custom Field
# TODO

## 12.1 Learning Curve: Access
# TODO

## 12.2 Learning Curve: Get Learning Curve
# TODO

## 12.3 Learning Curve: Get Learning Curve Points
# TODO

## 13.1 Model Value Parameters Export: Access
# TODO

## 13.2 Model Value Parameters Export: Export Model Values
# TODO

## 14.1 KCM Export: Access
# TODO

## 14.2 KCM Export: Export KCM
# TODO

## 15.1 KCM Import: Access
# TODO

## 15.2 KCM Import: Import KCM
# TODO

## 16.1 Authorization: Access
# TODO

## 16.2 Authorization: Get Authorization
# TODO

## 16.3 Authorization: Set Authorization
# TODO

# Report results on completion
reportResults
