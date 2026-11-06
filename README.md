# Firefox for iOS: iOS UI Check showcase

[![Native UI check](https://github.com/Kofiloski/firefox-ios/actions/workflows/skills-public-check.yml/badge.svg?branch=skills-showcase&event=workflow_dispatch)](https://github.com/Kofiloski/firefox-ios/actions/workflows/skills-public-check.yml)

This independent fork demonstrates the [ios-ai-ui-check action](https://github.com/Kofiloski/ios-ai-ui-check) against the real [Firefox for iOS app](https://github.com/mozilla-mobile/firefox-ios). The workflow builds the app, invokes the released v0.6.0 action, and collects native XCTest results and video.

- **Tested flow:** Long-press the tabs button, create a tab, and assert two real tab-tray cells.
- **Verified run:** [Passed on November 6, 2026](https://github.com/Kofiloski/firefox-ios/actions/runs/42133538018). 1 UI test passed through our action, with zero failures or skips.
- **Coverage:** Pinned Firefox branch snapshot. This baseline covers tab creation; release-wide coverage and Firefox Focus are outside its scope.

The baseline workflow uses a checked-in scenario. No AXe or model API key is required; live AI planning is not exercised by this example.

[Run in GitHub Actions](https://github.com/Kofiloski/firefox-ios/actions/workflows/skills-public-check.yml) · [Reproduce and inspect coverage](docs/skills-showcase.md) · [Get the toolkit](https://github.com/Kofiloski/ios-release-quality-toolkit)

This fork is not affiliated with or endorsed by the upstream project. Its source attribution and license are retained below.

Release-diff generation is configured separately in [Release diff UI regressions](.github/workflows/skills-release-regression.yml). It requires provider credentials and an explicit scheduling opt-in; [setup and verification status](docs/skills-showcase.md#release-diff-regressions). No live model-generated release run has been verified yet.

<details>
<summary>Upstream app documentation</summary>

Download [Firefox iOS](https://apps.apple.com/app/firefox-web-browser/id989804926) and [Focus iOS](https://itunes.apple.com/app/id1055677337) on the App Store.

<table>
  <tr>
    <th style="border: none;"><strong>Firefox iOS</strong></th>
    <td style="border: none;"><img src="https://img.shields.io/badge/Xcode-27.1-blue?logo=Xcode&logoColor=white" alt="Firefox-iOS"></td>
    <td style="border: none;"><img src="https://img.shields.io/badge/Swift-6.2-red?logo=Swift&logoColor=white" alt="Firefox-iOS"></td>
    <td style="border: none;"><img src="https://img.shields.io/badge/iOS-15.0+-green?logo=apple&logoColor=white" alt="Firefox-iOS"></td>
  </tr>
  <tr>
    <th style="border: none;"><strong>Focus iOS</strong></th>
    <td style="border: none;"><img src="https://img.shields.io/badge/Xcode-27.1-blue?logo=Xcode&logoColor=white" alt="Focus-iOS"></td>
    <td style="border: none;"><img src="https://img.shields.io/badge/Swift-6.2-red?logo=Swift&logoColor=white" alt="Focus-iOS"></td>
    <td style="border: none;"><img src="https://img.shields.io/badge/iOS-15.0+-green?logo=apple&logoColor=white" alt="Focus-iOS"></td>
  </tr>
</table>

## Building the code

This is a monolithic-repository, containing both the Firefox and Focus iOS projects.

As this is an iOS project, it is required to have Xcode on your system, and you should check that `xcode-select -p` points to `/Applications/Xcode.app/Contents/Developer` (or however you've named your `Xcode.app`).

### Automatic Installation (Recommended)
Steps: [Automated Project Setup with FXIOS](https://github.com/mozilla-mobile/firefox-ios/wiki/Automated-Project-Setup-with-FXIOS)

### Manual Installation

1. Clone the repo locally
1. For their related build instructions, please follow the respective project readmes:

- [Firefox for iOS](./firefox-ios/README.md)
- [Focus iOS](./focus-ios/README.md)

## Getting involved

We encourage you to participate in those open source projects. We love Pull Requests, Issue Reports, Feature Requests or any kind of positive contribution. Please read the [Mozilla Community Participation Guidelines](https://www.mozilla.org/en-US/about/governance/policies/participation/) and our [Contributing guidelines](https://github.com/mozilla-mobile/firefox-ios/blob/main/CONTRIBUTING.md) first.

- You can [file a new issue](https://github.com/mozilla-mobile/firefox-ios/issues/new/choose) or research [existing bugs](https://github.com/mozilla-mobile/firefox-ios/issues)

If more information is required or you have any questions then we suggest reaching out to us via:

- Chat on Element channel [#fx-ios](https://chat.mozilla.org/#/room/#fx-ios:mozilla.org) and [#focus-ios](https://chat.mozilla.org/#/room/#focus-ios:mozilla.org) for general discussion, or write DMs to specific teammates for questions.
- Open a [ticket](https://github.com/mozilla-mobile/firefox-ios/issues/new?template=BLANK_ISSUE) with your question.

Want to contribute on the codebase but don't know where to start? Here is a list of [issues that are contributor friendly](https://github.com/mozilla-mobile/firefox-ios/labels/Contributor%20OK), but make sure to read the [Contributing guidelines](https://github.com/mozilla-mobile/firefox-ios/blob/main/CONTRIBUTING.md) first.

## License

    This Source Code Form is subject to the terms of the Mozilla Public
    License, v. 2.0. If a copy of the MPL was not distributed with this
    file, You can obtain one at https://mozilla.org/MPL/2.0/

</details>
