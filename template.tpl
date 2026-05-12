___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "krystalview_tracker",
  "version": 1,
  "securityGroups": [],
  "displayName": "KrystalView Analytics",
  "description": "Load KrystalView analytics for session replay, heatmaps, and behavior insights.",
  "categories": ["ANALYTICS", "SESSION_RECORDING", "HEAT_MAP"],
  "brand": {
    "id": "krystalview",
    "displayName": "KrystalView"
  },
  "containerContexts": [
    "WEB"
  ]
}

___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "siteKey",
    "displayName": "Site key",
    "simpleValueType": true,
    "help": "Your KrystalView site key",
    "valueValidators": [
      {
        "type": "REQUIRED"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "secretKey",
    "displayName": "Secret key",
    "simpleValueType": true,
    "help": "Your KrystalView secret key",
    "valueValidators": [
      {
        "type": "REQUIRED"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "collectorUrl",
    "displayName": "Collector URL",
    "simpleValueType": true,
    "defaultValue": "https://collect.krystalview.com",
    "help": "Optional override for the collector endpoint"
  },
  {
    "type": "CHECKBOX",
    "name": "consentRequired",
    "checkboxText": "Require consent before recording",
    "simpleValueType": true,
    "defaultValue": true
  },
  {
    "type": "CHECKBOX",
    "name": "maskAllInputs",
    "checkboxText": "Mask all input values",
    "simpleValueType": true,
    "defaultValue": false
  },
  {
    "type": "TEXT",
    "name": "sampleRate",
    "displayName": "Sample rate (%)",
    "simpleValueType": true,
    "defaultValue": "100",
    "help": "Percentage of sessions to record (0-100)"
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___
const injectScript = require('injectScript');
const callInWindow = require('callInWindow');
const log = require('logToConsole');

const SCRIPT_URL = 'https://cdn.krystalview.com/kv.js';
const DEFAULT_COLLECTOR_URL = 'https://collect.krystalview.com';

const parseSampleRate = function (value) {
  const parsed = Number(value);
  if (parsed !== parsed) {
    return 1;
  }
  if (parsed <= 0) {
    return 0;
  }
  if (parsed >= 100) {
    return 1;
  }
  return parsed / 100;
};

const initConfig = {
  siteKey: data.siteKey,
  secretKey: data.secretKey,
  collectorUrl: data.collectorUrl || DEFAULT_COLLECTOR_URL,
  consentRequired: data.consentRequired !== false,
  maskAllInputs: data.maskAllInputs === true,
  sampleRate: parseSampleRate(data.sampleRate || '100')
};

injectScript(
  SCRIPT_URL,
  function () {
    try {
      callInWindow('KrystalView.init', initConfig);
      log('KrystalView initialized from GTM template');
      data.gtmOnSuccess();
    } catch (error) {
      log('KrystalView init failed: ' + error);
      data.gtmOnFailure();
    }
  },
  function () {
    log('KrystalView script injection failed: ' + SCRIPT_URL);
    data.gtmOnFailure();
  },
  SCRIPT_URL
);

___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "inject_script",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://cdn.krystalview.com/kv.js"
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
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "KrystalView.init"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
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
  }
]
