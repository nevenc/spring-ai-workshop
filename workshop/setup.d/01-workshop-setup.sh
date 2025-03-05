#!/bin/bash

set -x
set -eo pipefail

jq ". + { \"editor.fontSize\": 14, \"files.exclude\": { \".**\": true}}" /home/eduk8s/.local/share/code-server/User/settings.json > /home/eduk8s/.local/share/code-server/User/settings.json.tmp && mv /home/eduk8s/.local/share/code-server/User/settings.json.tmp /home/eduk8s/.local/share/code-server/User/settings.json

git clone https://github.com/natarajmb/spring-ai-intro

code-server --install-extension vmware.vscode-spring-boot
code-server --install-extension redhat.java
code-server --install-extension redhat.vscode-yaml
code-server --install-extension vscjava.vscode-java-debug
code-server --install-extension vscjava.vscode-maven
code-server --install-extension vscjava.vscode-java-dependency
code-server --install-extension vscjava.vscode-java-test
