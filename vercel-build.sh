#!/bin/bash
set -e

# Install Flutter SDK
git clone https://github.com/flutter/flutter.git \
  --depth 1 --branch stable /tmp/flutter

export PATH="/tmp/flutter/bin:$PATH"

flutter --version
flutter pub get
flutter build web --release

# Ensure Android and iOS association files are included
mkdir -p build/web/.well-known
cp web/.well-known/assetlinks.json build/web/.well-known/
cp web/.well-known/apple-app-site-association build/web/.well-known/