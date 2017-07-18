#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

#
# Trigger a Maven release using CircleCI.
#
#  usage: ./cicd/trigger-mvn-release.sh <CIRCLECI_API_TOKEN>
#

CIRCLE_TOKEN=${1:-}

ACCOUNT=datadotworld
PROJECT=excel-streaming-reader
BRANCH=master

if [[ -z "${CIRCLE_TOKEN}" ]]; then
  echo "usage: $0 <CIRCLECI_API_TOKEN>"
  exit 2
fi

curl -s -H "Content-Type: application/json" -d '{
    "build_parameters": {
        "MAVEN_RELEASE": "true"
    }
}' "https://circleci.com/api/v1/project/${ACCOUNT}/${PROJECT}/tree/${BRANCH}?circle-token=${CIRCLE_TOKEN}"
