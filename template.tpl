___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.

___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "GOXA Consent Mode",
  "brand": {
    "id": "brand_dummy",
    "displayName": "GOXA"
  },
  "description": "Connects GOXA Consent Manager with Google Consent Mode v2 in Google Tag Manager. Sets privacy-first defaults and updates consent from the GOXA consent cookie or dataLayer event.",
  "containerContexts": [
    "WEB"
  ],
  "categories": [
    "UTILITY",
    "ANALYTICS",
    "ADVERTISING"
  ]
}


___TEMPLATE_PARAMETERS___

[]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const setDefaultConsentState = require('setDefaultConsentState');
const updateConsentState = require('updateConsentState');
const getCookieValues = require('getCookieValues');
const copyFromDataLayer = require('copyFromDataLayer');
const gtagSet = require('gtagSet');
const JSON = require('JSON');

const COOKIE_NAME = 'goxa_cm_consent';
const DATA_LAYER_KEY = 'goxaConsentMode';
const CONFIG_LAYER_KEY = 'goxaConsentConfig';
const COOKIE_SCHEMA = 1;

const runtimeConfig = copyFromDataLayer(CONFIG_LAYER_KEY) || {};
const configuredWait = runtimeConfig.wait_for_update;
const waitForUpdate = configuredWait >= 0 && configuredWait <= 5000 ? configuredWait : 500;

// Keep GTM transport behavior aligned with the GOXA WordPress configuration.
gtagSet({
  ads_data_redaction: runtimeConfig.ads_data_redaction === true,
  url_passthrough: runtimeConfig.url_passthrough === true
});

const defaultState = {
  ad_storage: 'denied',
  analytics_storage: 'denied',
  ad_user_data: 'denied',
  ad_personalization: 'denied',
  functionality_storage: 'denied',
  personalization_storage: 'denied',
  security_storage: 'granted',
  wait_for_update: waitForUpdate
};

const normalize = (state) => ({
  ad_storage: state && state.ad_storage === 'granted' ? 'granted' : 'denied',
  analytics_storage: state && state.analytics_storage === 'granted' ? 'granted' : 'denied',
  ad_user_data: state && state.ad_user_data === 'granted' ? 'granted' : 'denied',
  ad_personalization: state && state.ad_personalization === 'granted' ? 'granted' : 'denied',
  functionality_storage: state && state.functionality_storage === 'granted' ? 'granted' : 'denied',
  personalization_storage: state && state.personalization_storage === 'granted' ? 'granted' : 'denied',
  security_storage: 'granted'
});

const fromCategories = (cats) => ({
  ad_storage: cats.indexOf('marketing') >= 0 ? 'granted' : 'denied',
  analytics_storage: cats.indexOf('analytics') >= 0 ? 'granted' : 'denied',
  ad_user_data: cats.indexOf('marketing') >= 0 ? 'granted' : 'denied',
  ad_personalization: cats.indexOf('marketing') >= 0 ? 'granted' : 'denied',
  functionality_storage: cats.indexOf('functional') >= 0 ? 'granted' : 'denied',
  personalization_storage: cats.indexOf('functional') >= 0 ? 'granted' : 'denied',
  security_storage: 'granted'
});

/*
 * One tag intentionally serves two triggers. On Consent Initialization there is
 * no goxaConsentMode object yet, so the template sets the privacy-first default.
 * The runtime publishes goxaConsentMode only after a visitor decision, so the
 * custom event path performs updateConsentState without resetting the default.
 */
const liveState = copyFromDataLayer(DATA_LAYER_KEY);
if (liveState) {
  updateConsentState(normalize(liveState));
} else {
  setDefaultConsentState(defaultState);
  const values = getCookieValues(COOKIE_NAME, true);
  if (values && values.length) {
    // GTM's sandbox JSON API returns undefined for malformed JSON.
    // try/catch is intentionally avoided because sandboxed JavaScript does not support it.
    const saved = JSON.parse(values[0]);
    const supportedSchema = saved && (!saved.schema || saved.schema === COOKIE_SCHEMA);
    if (supportedSchema && saved.cats && saved.cats.length) {
      updateConsentState(fromCategories(saved.cats));
    }
  }
}

data.gtmOnSuccess();


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "read_data_layer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedKeys",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "keyPatterns",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "goxaConsentMode"
              },
              {
                "type": 1,
                "string": "goxaConsentConfig"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "get_cookies",
        "versionId": "1"
      },
      "param": [
        {
          "key": "cookieAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "cookieNames",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "goxa_cm_consent"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_consent",
        "versionId": "1"
      },
      "param": [
        {
          "key": "consentTypes",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {"type":1,"string":"consentType"},
                  {"type":1,"string":"read"},
                  {"type":1,"string":"write"}
                ],
                "mapValue": [
                  {"type":1,"string":"ad_storage"},
                  {"type":8,"boolean":false},
                  {"type":8,"boolean":true}
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {"type":1,"string":"consentType"},
                  {"type":1,"string":"read"},
                  {"type":1,"string":"write"}
                ],
                "mapValue": [
                  {"type":1,"string":"analytics_storage"},
                  {"type":8,"boolean":false},
                  {"type":8,"boolean":true}
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {"type":1,"string":"consentType"},
                  {"type":1,"string":"read"},
                  {"type":1,"string":"write"}
                ],
                "mapValue": [
                  {"type":1,"string":"ad_user_data"},
                  {"type":8,"boolean":false},
                  {"type":8,"boolean":true}
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {"type":1,"string":"consentType"},
                  {"type":1,"string":"read"},
                  {"type":1,"string":"write"}
                ],
                "mapValue": [
                  {"type":1,"string":"ad_personalization"},
                  {"type":8,"boolean":false},
                  {"type":8,"boolean":true}
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {"type":1,"string":"consentType"},
                  {"type":1,"string":"read"},
                  {"type":1,"string":"write"}
                ],
                "mapValue": [
                  {"type":1,"string":"functionality_storage"},
                  {"type":8,"boolean":false},
                  {"type":8,"boolean":true}
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {"type":1,"string":"consentType"},
                  {"type":1,"string":"read"},
                  {"type":1,"string":"write"}
                ],
                "mapValue": [
                  {"type":1,"string":"personalization_storage"},
                  {"type":8,"boolean":false},
                  {"type":8,"boolean":true}
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {"type":1,"string":"consentType"},
                  {"type":1,"string":"read"},
                  {"type":1,"string":"write"}
                ],
                "mapValue": [
                  {"type":1,"string":"security_storage"},
                  {"type":8,"boolean":false},
                  {"type":8,"boolean":true}
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "write_data_layer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keyPatterns",
          "value": {
            "type": 2,
            "listItem": [
              {"type":1,"string":"ads_data_redaction"},
              {"type":1,"string":"url_passthrough"}
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: Fresh visitor gets privacy-first default
  code: |-
    const mockData = {};
    mock('copyFromDataLayer', (key) => key === 'goxaConsentConfig' ? {wait_for_update: 500, ads_data_redaction: true, url_passthrough: true} : undefined);
    mock('getCookieValues', () => []);
    runCode(mockData);
    assertApi('gtagSet').wasCalledWith({
      ads_data_redaction: true,
      url_passthrough: true
    });
    assertApi('setDefaultConsentState').wasCalledWith({
      ad_storage: 'denied', analytics_storage: 'denied',
      ad_user_data: 'denied', ad_personalization: 'denied',
      functionality_storage: 'denied', personalization_storage: 'denied',
      security_storage: 'granted', wait_for_update: 500
    });
    assertApi('updateConsentState').wasNotCalled();
- name: Accept all live event updates without resetting default
  code: |-
    const mockData = {};
    mock('copyFromDataLayer', (key) => {
      if (key === 'goxaConsentConfig') return {wait_for_update: 700, ads_data_redaction: false, url_passthrough: true};
      if (key === 'goxaConsentMode') return {
        ad_storage: 'granted', analytics_storage: 'granted',
        ad_user_data: 'granted', ad_personalization: 'granted',
        functionality_storage: 'granted', personalization_storage: 'granted',
        security_storage: 'granted'
      };
    });
    runCode(mockData);
    assertApi('updateConsentState').wasCalledWith({
      ad_storage: 'granted', analytics_storage: 'granted',
      ad_user_data: 'granted', ad_personalization: 'granted',
      functionality_storage: 'granted', personalization_storage: 'granted',
      security_storage: 'granted'
    });
    assertApi('setDefaultConsentState').wasNotCalled();
- name: Reject all live event keeps security storage granted
  code: |-
    const mockData = {};
    mock('copyFromDataLayer', (key) => {
      if (key === 'goxaConsentConfig') return {wait_for_update: 500, ads_data_redaction: true, url_passthrough: false};
      if (key === 'goxaConsentMode') return {
        ad_storage: 'denied', analytics_storage: 'denied',
        ad_user_data: 'denied', ad_personalization: 'denied',
        functionality_storage: 'denied', personalization_storage: 'denied',
        security_storage: 'granted'
      };
    });
    runCode(mockData);
    assertApi('updateConsentState').wasCalledWith({
      ad_storage: 'denied', analytics_storage: 'denied',
      ad_user_data: 'denied', ad_personalization: 'denied',
      functionality_storage: 'denied', personalization_storage: 'denied',
      security_storage: 'granted'
    });
    assertApi('setDefaultConsentState').wasNotCalled();
- name: Returning visitor functional-only cookie maps correctly
  code: |-
    const mockData = {};
    mock('copyFromDataLayer', (key) => key === 'goxaConsentConfig' ? {wait_for_update: 500, ads_data_redaction: true, url_passthrough: true} : undefined);
    mock('getCookieValues', () => ['{"schema":1,"cats":["functional"]}']);
    runCode(mockData);
    assertApi('setDefaultConsentState').wasCalled();
    assertApi('updateConsentState').wasCalledWith({
      ad_storage: 'denied', analytics_storage: 'denied',
      ad_user_data: 'denied', ad_personalization: 'denied',
      functionality_storage: 'granted', personalization_storage: 'granted',
      security_storage: 'granted'
    });
- name: Returning visitor analytics-only cookie maps correctly
  code: |-
    const mockData = {};
    mock('copyFromDataLayer', (key) => key === 'goxaConsentConfig' ? {wait_for_update: 900, ads_data_redaction: true, url_passthrough: false} : undefined);
    mock('getCookieValues', () => ['{"schema":1,"cats":["analytics"]}']);
    runCode(mockData);
    assertApi('setDefaultConsentState').wasCalledWith({
      ad_storage: 'denied', analytics_storage: 'denied',
      ad_user_data: 'denied', ad_personalization: 'denied',
      functionality_storage: 'denied', personalization_storage: 'denied',
      security_storage: 'granted', wait_for_update: 900
    });
    assertApi('updateConsentState').wasCalledWith({
      ad_storage: 'denied', analytics_storage: 'granted',
      ad_user_data: 'denied', ad_personalization: 'denied',
      functionality_storage: 'denied', personalization_storage: 'denied',
      security_storage: 'granted'
    });
- name: Structurally invalid cookie fails closed without update
  code: |-
    const mockData = {};
    mock('copyFromDataLayer', (key) => key === 'goxaConsentConfig' ? {wait_for_update: 500, ads_data_redaction: true, url_passthrough: true} : undefined);
    mock('getCookieValues', () => ['{"schema":1,"cats":{}}']);
    runCode(mockData);
    assertApi('setDefaultConsentState').wasCalled();
    assertApi('updateConsentState').wasNotCalled();
- name: Unsupported future cookie schema fails closed without update
  code: |-
    const mockData = {};
    mock('copyFromDataLayer', (key) => key === 'goxaConsentConfig' ? {wait_for_update: 500, ads_data_redaction: true, url_passthrough: true} : undefined);
    mock('getCookieValues', () => ['{"schema":2,"cats":["functional","analytics","marketing"]}']);
    runCode(mockData);
    assertApi('setDefaultConsentState').wasCalledWith({
      ad_storage: 'denied', analytics_storage: 'denied',
      ad_user_data: 'denied', ad_personalization: 'denied',
      functionality_storage: 'denied', personalization_storage: 'denied',
      security_storage: 'granted', wait_for_update: 500
    });
    assertApi('updateConsentState').wasNotCalled();


___NOTES___

Created on 6.08.2026, 16:13:45


