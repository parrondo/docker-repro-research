#!/bin/bash

set -e # Exit script immediately on first error.
set -x # Print commands and their arguments as they are executed.i

#export DOCKER_HOST=tcp://localhost:44243
docker build -t="invenshure/sciencetemp" .

