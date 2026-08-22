# GOXA Consent Mode — Google Tag Manager Template

GOXA Consent Mode is a custom Google Tag Manager Web template that connects **GOXA Consent Manager** with **Google Consent Mode v2**.

It applies privacy-first consent defaults during Consent Initialization and updates consent after a visitor makes or changes a choice in GOXA Consent Manager.

## Features

- Google Consent Mode v2 support for `ad_storage`, `analytics_storage`, `ad_user_data` and `ad_personalization`.
- Additional support for functionality, personalization and security storage.
- Privacy-first default consent state.
- Consent updates from the GOXA consent cookie and `goxa_consent_update` workflow.
- Shared `wait_for_update`, `ads_data_redaction` and `url_passthrough` configuration with GOXA Consent Manager.
- Versioned first-party consent cookie contract.
- Sandboxed Google Tag Manager template APIs only.

## Installation

1. In Google Tag Manager, open **Templates → Tag Templates → New → Import**.
2. Import `template.tpl`.
3. Create a tag using **GOXA Consent Mode**.
4. Add **Consent Initialization – All Pages**.
5. Add a second trigger for the custom event `goxa_consent_update`.
6. Validate the implementation in Tag Assistant / Preview before publishing changes.

## Validation

The template bundled with GOXA Consent Manager was imported into Google Tag Manager Template Editor and passed all 7 included test scenarios.

Validated template SHA-256:

`aee9b07d63900d5f5588ebac3e914a6055d2d9ecc7ad01609e9d7cb2eb9a0d84`

## Documentation

https://goxa.eu/docs/gtm-consent-mode/

## Homepage

https://goxa.eu/

## License

Apache License 2.0. See `LICENSE`.

GOXA Consent Mode is an independent template and is not described as certified, approved or endorsed by Google.
