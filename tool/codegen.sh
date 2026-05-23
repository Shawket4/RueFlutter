#!/usr/bin/env bash
set -euo pipefail

# Source of truth for the OpenAPI spec. Override via env var in CI.
OPENAPI_SPEC="${OPENAPI_SPEC:-$HOME/Desktop/SufrixRust/openapi.json}"
OUT_DIR="lib/api_generated"

if [[ ! -f "$OPENAPI_SPEC" ]]; then
  echo "✗ Spec not found: $OPENAPI_SPEC"
  echo "  Set OPENAPI_SPEC env var or place the file there."
  exit 1
fi

echo "→ Spec: $OPENAPI_SPEC"
echo "→ Output: $OUT_DIR"

# Wipe the previous output so deleted endpoints/types don't linger.
rm -rf "$OUT_DIR"

# Generate
OPENAPI_SPEC="$OPENAPI_SPEC" openapi-generator-cli generate \
  -c openapi-generator-config.yaml

# build_runner inside the generated package — built_value needs this to
# produce *.g.dart implementation files for each model.
echo "→ Running build_runner inside generated package"
pushd "$OUT_DIR" > /dev/null
dart pub get
dart run build_runner build --delete-conflicting-outputs
popd > /dev/null

# Re-resolve top-level project deps (path: dependency may need refresh).
flutter pub get

echo "✓ Codegen complete"