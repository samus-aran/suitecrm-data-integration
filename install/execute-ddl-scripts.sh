#!/bin/bash

cd ../suitecrm-data-integration/scripts/
./kitchen.sh -file=../../install/executeDDLScripts.kjb -level=Error > /dev/null
