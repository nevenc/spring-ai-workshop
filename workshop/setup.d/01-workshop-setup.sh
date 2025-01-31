#!/bin/bash

set -x
set -eo pipefail

jq ". + { \"editor.fontSize\": 14, \"files.exclude\": { \".**\": true}}" /home/eduk8s/.local/share/code-server/User/settings.json > /home/eduk8s/.local/share/code-server/User/settings.json.tmp && mv /home/eduk8s/.local/share/code-server/User/settings.json.tmp /home/eduk8s/.local/share/code-server/User/settings.json

git clone https://github.com/nevenc/spring-ai-zero-to-hero spring-ai-zero-to-hero