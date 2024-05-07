#!/usr/bin/env bash

set -e

# Import test library bundled with the devcontainer CLI
# See https://github.com/devcontainers/cli/blob/HEAD/docs/features/test.md#dev-container-features-test-lib
# Provides the 'check' and 'reportResults' commands.
source dev-container-features-test-lib

# Run DataShop Queries
# See https://pslcdatashop.web.cmu.edu/api/DataShop%20Public%20API-v0.41.pdf

## 6.1 Getting Data: Get Dataset Metadata
check '6.1 Getting Data: Get Dataset Metadata' datashop -u https://pslc-qa.andrew.cmu.edu/datashop /datasets/1142
# TODO: Request Parameters, Path Variables, Error Tests

## 6.2 Getting Data: Get Project Metadata
check '6.2 Getting Data: Get Project Metadata' datashop -u https://pslc-qa.andrew.cmu.edu/datashop /datasets/projects/34
# TODO: Request Parameters, Path Variables, Error Tests

## 6.3 Getting Data: Get Sample Metadata
check '6.3 Getting Data: Get Sample Metadata' datashop -u https://pslc-qa.andrew.cmu.edu/datashop /datasets/1142/samples/4393
# TODO: Request Parameters, Path Variables, Error Tests

## 6.4 Getting Data: Get Transactions (TODO: FIX FAILURE)
# check '6.4 Getting Data: Get Transactions' datashop -u https://pslc-qa.andrew.cmu.edu/datashop /datasets/1142/samples/4393/transactions
# TODO: Request Parameters, Path Variables, Error Tests

## 6.5 Getting Data: Get Student-Step Records (TODO: FIX FAILURE)
# check '6.5 Getting Data: Get Student-Step Records' datashop -u https://pslc-qa.andrew.cmu.edu/datashop /datasets/1142/samples/4393/steps
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
