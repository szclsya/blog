#!/bin/bash
set -euo pipefail

# Install build essentials
pnpm install postcss-cli postcss autoprefixer

# Build
hugo

# Add redirect info
cp -v ./_redirects ./public/_redirects
