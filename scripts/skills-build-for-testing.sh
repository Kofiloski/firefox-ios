#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"
: "${AI_UI_SIMULATOR_UDID:?Select a dedicated test Simulator first}"
DERIVED_DATA_PATH="${AI_UI_DERIVED_DATA_PATH:-$ROOT_DIR/.derivedData/ai-ui}"

# Prepare only the reviewed build prerequisites, without bootstrap's host hooks.
./scripts/install-swiftlint.sh
python3 - <<'PY'
import hashlib
from pathlib import Path
import urllib.request

base = "https://raw.githubusercontent.com/mozilla/application-services/af81da7208a53c47e3ada8b17a4a172a25bd9d87/components/nimbus/ios/scripts/"
files = {
    "nimbus-fml.sh": "443a72235811e6367914f80b2eacc900d55913442cb9d594930170e0e2cc5da4",
    "nimbus-fml-configuration.local.sh": "1fc4c18d4f01d0e378bfd13eca42252a9911a4e473ece66abbb4c179202b9388",
}
for name, expected in files.items():
    path = Path("firefox-ios/bin") / name
    data = path.read_bytes() if path.exists() else urllib.request.urlopen(base + name, timeout=60).read()
    if hashlib.sha256(data).hexdigest() != expected:
        raise SystemExit(f"Unexpected Nimbus prerequisite: {path}; review it before replacing or executing it")
    if not path.exists():
        path.write_bytes(data)
    path.chmod(0o755)
PY

xcodebuild build-for-testing \
  -project firefox-ios/Client.xcodeproj -scheme SkillsPublicUI -configuration Debug \
  -testPlan Smoketest \
  -only-testing:XCUITests/TabsTestsIphone/testAddTabByLongPressTabsButton \
  -destination "platform=iOS Simulator,id=$AI_UI_SIMULATOR_UDID,arch=$(uname -m)" \
  -derivedDataPath "$DERIVED_DATA_PATH" \
  -disableAutomaticPackageResolution -onlyUsePackageVersionsFromResolvedFile \
  -packageAuthorizationProvider netrc -skipMacroValidation \
  -jobs 2 -parallel-testing-enabled NO \
  CODE_SIGNING_ALLOWED=YES CODE_SIGN_IDENTITY=- CODE_SIGN_STYLE=Manual \
  DEVELOPMENT_TEAM= PROVISIONING_PROFILE_SPECIFIER= COMPILER_INDEX_STORE_ENABLE=NO
