#!/bin/bash

set -eo pipefail

CONFIG_DIR="${CONFIG_DIR-/etc/snikket-integration-tests}"

jq -r '"machine api-cloud.browserstack.com login "+.["browserstack.user"]+" password "+.["browserstack.key"]' \
	"${CONFIG_DIR}/browserstack-auth.json" > "$HOME/.netrc-browserstack"

BROWSERSTACK_USER=$(jq -r '.["browserstack.user"]' "${CONFIG_DIR}/browserstack-auth.json")
BROWSERSTACK_KEY=$(jq -r '.["browserstack.key"]' "${CONFIG_DIR}/browserstack-auth.json")

echo "machine api-cloud.browserstack.com login $BROWSERSTACK_USER password $BROWSERSTACK_KEY" \
	> $HOME/.netrc-browserstack

APK_FILE=$(find build/outputs/apk -name '*-universal-*.apk' | head -n1)

exec curl --netrc-file "$HOME/.netrc-browserstack" \
	-X POST "https://api-cloud.browserstack.com/app-automate/upload" \
	-F "file=@$APK_FILE" \
	-F "custom_id=$1";
