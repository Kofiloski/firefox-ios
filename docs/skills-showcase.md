---
summary: Reproduce the independent Firefox native UI showcase without a model API key.
read_when:
  - Running the public skills workflow or its local equivalent
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
