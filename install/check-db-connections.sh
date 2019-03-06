#!/bin/bash

cd ../suitecrm-data-integration/scripts/
./kitchen.sh -file=../../install/checkDBConnections.kjb -level=Error > /dev/null
