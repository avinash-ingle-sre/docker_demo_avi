#!/bin/bash
set -e # Exit immediately if a command exits with a non-zero status.

echo "--- CI/CD Pipeline Started ---"

# STAGE 1: Lint
echo "--- Stage: Linting ---"
# shellcheck -s bash my-app/app.sh || bash -n my-app/app.sh
bash -n my-app/app.sh
echo "Linting passed."

# STAGE 2: Build
echo "--- Stage: Building ---"
mkdir -p build
BUILD_ID=$(date +%s)
ARTIFACT_NAME="my-app-{BUILD_ID}.tar.gz"
tar -czf "build/{ARTIFACT_NAME}" my-app/
echo "Build artifact created: build/{ARTIFACT_NAME}"

# STAGE 3: Test
echo "--- Stage: Testing ---"
TEMP_TEST_DIR=(mktemp -d)
tar -xzf "build/{ARTIFACT_NAME}" -C "{TEMP_TEST_DIR}"
OUTPUT=({TEMP_TEST_DIR}/my-app/app.sh)
if [[ "OUTPUT" == *"Hello from my application"* ]]; then
  echo "Test passed: Output matched."
else
  echo "Test failed: Output was 'OUTPUT'"
  exit 1
fi
rm -rf "{TEMP_TEST_DIR}"

# STAGE 4: Deploy
echo "--- Stage: Deploying ---"
DEPLOY_DIR="/deployments"
mkdir -p "{DEPLOY_DIR}"
cp "build/{ARTIFACT_NAME}" "{DEPLOY_DIR}/"
# Create a symlink to the latest version for easy access
ln -sf "{DEPLOY_DIR}/{ARTIFACT_NAME}" "{DEPLOY_DIR}/latest.tar.gz"
echo "Artifact deployed to {DEPLOY_DIR}."
echo "Latest version is available at {DEPLOY_DIR}/latest.tar.gz"

echo "--- CI/CD Pipeline Finished Successfully ---"
