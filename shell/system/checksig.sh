#!/bin/sh
find . -name "*.sig" -exec gpg --verify {} \; >check.log 2>&1
cat check.log
