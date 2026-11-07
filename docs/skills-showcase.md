---
summary: Reproduce the independent Firefox native UI showcase without a model API key.
read_when:
  - Running the public skills workflow or its local equivalent
  - Comparing upstream releases and reviewing generated UI test reports
  - Interpreting the Firefox tab-creation test evidence
---

# Independent Firefox skills example

This fork preserves Mozilla's MPL-2.0 source and attribution. It is an independent
testing example, without Mozilla endorsement. App source is pinned to
`373f4ae9a082155e5953e8595647316dae2631fd`, an inspected branch snapshot. A released
comparison pair has not been selected for Firefox.

The provided scenario maps to the existing
`XCUITests/TabsTestsIphone/testAddTabByLongPressTabsButton` test. Its existing
fixtures launch a clean test profile, skip onboarding, create a tab through the
toolbar's long-press menu, open the tab tray and assert that its real UI has two
cells. No credentials, model key or external UI inspector are needed. The runner
rejects other steps and requires exactly one passing, unskipped test in the
XCTest result bundle. AI planning/inspection is not configured for this fixed
native-test example.

## Local reproduction

Use Xcode 27.1 and an isolated iPhone Simulator on iOS 27.0. Set `DEVELOPER_DIR`,
`AI_UI_SIMULATOR_UDID`, and optionally `AI_UI_DERIVED_DATA_PATH`. The test clears
its app profile; use a dedicated test Simulator.

```bash
npm ci --ignore-scripts
npm run build
bash scripts/skills-build-for-testing.sh
bash scripts/run-ai-ui-scenario.sh .github/ai-ui/verify-primary-flow.json
```

`SkillsPublicUI` selects only the app and UI test with the `Smoketest` plan. It
omits the upstream scheme's explicit unit-test build entries, inherited
`Testables`, coverage targets and archive script. Selecting a test plan alone
does not remove those extra build targets. Production source and existing UI
test logic are unchanged.

The helper uses the upstream lockfiles, repository-local checksum-pinned
SwiftLint, and reviewed Nimbus scripts from application-services commit
`af81da7208a53c47e3ada8b17a4a172a25bd9d87`. It avoids the root bootstrap's hook
installation and virtual-environment deletion. The reviewed ModifiedCopy macro
is authorized only for the build command. Glean uses the upstream generator's
Python virtual environment and version ranges; the hosted workflow records its
resolved packages rather than claiming they are fully locked.

## Evidence and limits

The local Simulator app test build and one native UI test passed, with zero
failures or skips. The released action's scripts captured video and an XCTest
result bundle. The [hosted run](https://github.com/Kofiloski/firefox-ios/actions/runs/42133538018)
also passed: one test, zero failures/skips, with the native long-press, tab
creation and tray assertion confirmed in its log and a 14 MB video retained.
This verifies the selected
tab-creation flow; it does not establish all Firefox features, release-wide
coverage, physical-device behavior or live model planning.

The public workflow is manual. Inherited upstream release, issue-management and
notification workflows are disabled on this showcase fork.

## Release-diff regressions

The separate `skills-release-regression.yml` workflow resolves stable upstream iOS
tags, compares the exact previous/new commits, builds and inspects the compared
head, then generates new JSON scenarios tied to changed files. Each generated
case runs through native XCTest; empty/skipped test selections cannot pass.
Uncovered or unreachable changes remain explicit in the report. The baseline
workflow above still replays a fixed scenario and is separate evidence.

Set a repository secret `ANTHROPIC_API_KEY`, `OPENAI_API_KEY`, or the explicit
provider-neutral `AI_UI_PLANNER_API_KEY`. Configure provider/model/effort with the
manual inputs or `AI_UI_PLANNER_*` repository variables. A compatible endpoint
uses `AI_UI_PLANNER_BASE_URL` and its own neutral key. Keys are never borrowed
from another provider. No model keys are currently configured in this fork.

Run the workflow manually first. Missing credentials or incomplete planning,
builds or native execution produce a blocked/failing report; there is no fixed
baseline fallback. This frozen reference has no scheduled trigger and keeps
`ENABLE_RELEASE_CHECKS=false`. Resuming recurring checks requires a reviewed
schedule change as well as the variable and a verified live planner run. First discovery
starts at the latest pair instead of backfilling the entire catalog. Subsequent
new tags, including hotfixes, enter a persisted queue. Manual `head_tag` and
`base_tag` inputs replay historical pairs; older toolchains or harness conflicts
are reported as blocked. Use `force` or an explicit tag to retry repaired runs.

Reports and full diagnostic evidence are immutable attempt assets under this
fork's `ui-check-*` GitHub releases, independent of Actions artifact retention.
`ui-check-state` stores discovery state. These are test reports, not upstream
app releases. Build/inspect/test jobs have read-only repository permissions and
no model key; model planning occurs in a separate Ubuntu job that never runs app
code. Only the history job can publish reports. The workflow does not post to
upstream issues or PRs.

The app profile in `.github/ai-ui/release-profile.json` owns stable tag filters,
the source seed for the harness overlay, reviewed launch presets, and build/test
configuration. A changed upstream project may require a reviewed profile update.
No live provider generation or full release-flow execution has been verified yet.

The [credential-gate run on November 6, 2026](https://github.com/Kofiloski/firefox-ios/actions/runs/42296868891)
resolved firefox-v159.1 → firefox-v160.0, skipped the macOS/planning/execution jobs, and
[archived a blocked report and evidence](https://github.com/Kofiloski/firefox-ios/releases/tag/ui-check-62cb1733381a4b2dae69).
The final coverage gate failed deliberately. This verifies missing-key handling
and historical publication; it does not establish generated UI coverage.

## Maintenance status

This fork became a frozen integration reference on November 7, 2026. Its source
snapshot and historical native evidence remain available, and manual checks can
still be run. The scheduled release trigger is removed and
`ENABLE_RELEASE_CHECKS=false`; current upstream releases are not followed
automatically. DuckDuckGo is the active behavioral flagship. This does not
reclassify the existing baseline as generated release coverage.

The baseline runner now rejects non-iPhone destinations before XCTest. This
prevents an unsupported destination from counting the upstream test's early
return as a passing UI assertion. The historical hosted iPhone pass remains
valid; the guard was checked separately with iPhone, iPad and missing-device
fixtures.

## Permanent native evidence

The [verified baseline bundle](https://github.com/Kofiloski/firefox-ios/releases/tag/skills-baseline-42133538018) preserves the
original native result bundles, scenario, logs and recording, with source, harness
and action revisions. Asset hashes and the native result counts were verified
before publication. These fixed baseline records remain separate from live
model-generated release tests.
