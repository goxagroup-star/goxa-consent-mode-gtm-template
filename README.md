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

The GOXA template application logic previously passed all 7 included Google Tag Manager Template Editor test scenarios.

The Community Template Gallery candidate adds only Google's required `___TERMS_OF_SERVICE___` section; the runtime code and test scenarios are unchanged. This Gallery candidate must be re-imported and the 7/7 tests re-run before final submission evidence is recorded.

Gallery candidate SHA-256:

`dd498171bba5b34ad60c2af73aa5a0e0b5166d52ee74279dbf38b6264a122821`

## Documentation

https://goxa.eu/docs/gtm-consent-mode/

## Homepage

https://goxa.eu/

## License

Apache License 2.0. See `LICENSE`.

GOXA Consent Mode is an independent template and is not described as certified, approved or endorsed by Google.
