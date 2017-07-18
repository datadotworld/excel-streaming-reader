#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail -o xtrace

#
# Called indirectly by trigger-mvn-release.sh via circle.yml
#

# Parameterized build sets the MAVEN_RELEASE=true for releases
if [[ "${MAVEN_RELEASE:-}" != true ]]; then
  exit 0
fi

git config user.email "admin@data.world"
git config user.name "CircleCI"

mvn release:prepare -B -s settings.xml
mvn release:perform -B -s settings.xml -Darguments="-Dmaven.test.skip=true"
mvn release:clean
