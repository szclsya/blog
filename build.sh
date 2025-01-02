#!/bin/bash
set -euo pipefail

# Install build essentials
npm install autoprefixer postcss postcss-cli

# Build
hugo

# Add redirect info
cp -v ./_redirects ./public/_redirects
