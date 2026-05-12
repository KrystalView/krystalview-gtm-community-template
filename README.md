# KrystalView Analytics GTM Template

Google Tag Manager Community Template Gallery package for loading `https://cdn.krystalview.com/kv.js` and initializing KrystalView analytics.

## Files

- `template.tpl` - exported web tag template.
- `metadata.yaml` - Gallery metadata and release SHA list.
- `LICENSE` - Apache License 2.0, required by Google for Gallery submissions.

## Parameters

- `Site key` - required KrystalView site key.
- `Secret key` - required KrystalView secret key.
- `Collector URL` - optional collector endpoint override. Defaults to `https://collect.krystalview.com`.
- `Require consent before recording` - enabled by default.
- `Mask all input values` - optional masking toggle.
- `Sample rate (%)` - percentage of sessions to record, from `0` to `100`. Defaults to `100`.

## Required permissions

The template requests the minimum web-template permissions needed to run:

- Inject script: `https://cdn.krystalview.com/kv.js`.
- Access global variable: `KrystalView.init`.
- Logging: debug/preview logging only.

## Local import

1. Open a GTM web container.
2. Go to `Templates`.
3. Under `Tag Templates`, click `New`.
4. Open the menu and select `Import`.
5. Import `template.tpl`.
6. Save the template as `KrystalView Analytics`.

## Tag setup

1. Go to `Tags` -> `New`.
2. Select `KrystalView Analytics` from custom templates.
3. Fill in the required site and secret keys.
4. Keep `Require consent before recording` enabled unless your implementation has another consent gate.
5. Set the trigger to `All Pages`.
6. Preview, test, and publish the GTM container.

## Gallery submission notes

Google's current Community Template Gallery flow expects a dedicated public GitHub repository with `template.tpl`, `metadata.yaml`, and `LICENSE` at the repository root. The `metadata.yaml` `versions[].sha` value must be a concrete commit SHA that contains the template version to publish.

This package is submission-ready source material. Before submitting to the Gallery, publish the fork-ready repository prepared in `/tmp/gtm-submission-workdir/krystalview-gtm-community-template` and submit that GitHub repository URL through `tagmanager.google.com/gallery`.
