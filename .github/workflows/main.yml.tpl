#!/usr/bin/env bash
set -euo pipefail

GIT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
SUPPORT_FIRECLOUD_DIR="$(cd "${GIT_ROOT}/support-firecloud" && pwd)"

SRC_FILE=.github/workflows.src/main.yml

export ENVSUBST_SF_VSN=$(cat ${SUPPORT_FIRECLOUD_DIR}/package.json | jq -r ".version")

echo "# WARNING: DO NOT EDIT. AUTO-GENERATED CODE (${SRC_FILE})"
cat ${GIT_ROOT}/${SRC_FILE} | \
  envsubst "$(printenv | grep "^ENVSUBST_" | sed "s/=.*//g" | sed "s/^/\${/g" | sed "s/\$/}/g")" | \
  ${SUPPORT_FIRECLOUD_DIR}/bin/yaml-expand
