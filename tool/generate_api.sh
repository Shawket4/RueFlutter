#!/usr/bin/env bash
# Regenerates the OpenAPI model package (packages/sufrix_api) from the
# SufrixRust backend spec. POS equivalent of the dashboard's `npm run
# generate:api`. Requires: cargo (backend checkout), node/npx, Java 11+.
set -euo pipefail

POS_DIR="$(cd "$(dirname "$0")/.." && pwd)"
BACKEND_DIR="${SUFRIX_BACKEND_DIR:-$POS_DIR/../SufrixRust}"
PKG_DIR="$POS_DIR/packages/sufrix_api"

echo "── 1/4 Exporting OpenAPI spec from backend…"
(cd "$BACKEND_DIR" && cargo run --bin export-openapi)

echo "── 2/4 Generating Dart models (models-only, json_serializable)…"
rm -rf "$PKG_DIR"
npx --yes @openapitools/openapi-generator-cli generate \
  -i "$BACKEND_DIR/openapi.json" \
  -g dart-dio \
  -o "$PKG_DIR" \
  --global-property models,supportingFiles \
  --additional-properties serializationLibrary=json_serializable,pubName=sufrix_api,enumUnknownDefaultCase=true

echo "── 3/4 Post-processing generated package…"
# Models-only generation leaves exports pointing at ungenerated client files.
python3 - "$PKG_DIR" <<'EOF'
import os, re, sys
pkg = sys.argv[1]
p = os.path.join(pkg, 'lib/sufrix_api.dart')
lines = open(p).read().split('\n')
out = []
for ln in lines:
    m = re.match(r"export 'package:sufrix_api/(.+)';", ln)
    if m and not os.path.exists(os.path.join(pkg, 'lib', m.group(1))):
        continue
    out.append(ln)
open(p, 'w').write('\n'.join(out))
EOF
# json_serializable >=6.9 emits null-aware elements (needs Dart >=3.8).
sed -i '' "s/sdk: '>=3.5.0 <4.0.0'/sdk: '>=3.8.0 <4.0.0'/" "$PKG_DIR/pubspec.yaml"

echo "── 4/5 build_runner…"
(cd "$PKG_DIR" && flutter pub get && dart run build_runner build --delete-conflicting-outputs)

echo "── 5/5 Wire tolerance + analyzer hygiene…"
# The backend serializes BigDecimal columns (quantity_used, current_stock,
# reorder_threshold, quantity_deducted, …) as JSON *strings*; the generated
# json_serializable code expects nums. Make every double parse string-tolerant.
python3 - "$PKG_DIR" <<'EOF'
import glob, sys
for p in glob.glob(sys.argv[1] + '/lib/src/model/*.g.dart'):
    src = open(p).read()
    out = src.replace('(v as num).toDouble()',
                      '(v is String ? double.parse(v) : (v as num).toDouble())') \
             .replace('(v as num?)?.toDouble()',
                      '(v is String ? double.parse(v) : (v as num?)?.toDouble())')
    if out != src:
        open(p, 'w').write(out)
EOF
# The generator wipes the package dir, taking our analysis_options with it.
# Re-write it so the generated code never pollutes `flutter analyze`.
cat > "$PKG_DIR/analysis_options.yaml" <<'EOF'
# Generated package — analysis and lints are intentionally disabled.
# This file is re-written by tool/generate_api.sh after every regeneration
# (the generator wipes this directory).
analyzer:
  errors:
    todo: ignore
  exclude:
    - '**'
linter:
  rules: []
EOF

echo "Done. Generated models live in packages/sufrix_api."
