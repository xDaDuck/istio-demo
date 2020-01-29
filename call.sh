#!/usr/bin/env bash

# SLEEP -> curl http://www.wikipedia.org
# ISTIO VS
# ISTIO DR TLS ORIGINATION
# PRIVATE PROXY
# https://demo-app

https_proxy=$HTTP_PROXY curl -I -k https://www.wikipedia.org/ 2>/dev/null | head -n 1 | cut -d$' ' -f2
