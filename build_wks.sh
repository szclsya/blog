#!/bin/bash
set -euo pipefail

PATTERN="@szclsya.me"


cd static
if ! [[ -d ".well-known/openpgpkey" ]]; then
   mkdir -p ./.well-known/openpgpkey
fi

cd .well-known
gpg --list-options show-only-fpr-mbox -k $PATTERN | grep -F "$PATTERN" | gpg-wks-client -v --install-key

