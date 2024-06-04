#!/bin/bash

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
cd "$dir"

rm -f ../ComplianceJson/*.json
forge test
