# Account

## Account(accountId:string, keyId:string, keySecret:string)
The *Account* class store your ali account information. Construct an account object is simple:

accountId: String, ali account id.

keyId: String, ali key id.

keySecret: String, ali key secret.
```javascript
    var AliMNS = require("ali-mns");
    var account = new AliMNS.Account("<your-owner-id>", "<your-key-id>", "<your-key-secret>");
```
The account object is usually passed as an argument for other class such as *MNS*, *MQ*

Follow [this link](https://ak-console.aliyun.com/#/accesskey) to find yours

## account.getAccountId()
Return the ali account id.

## account.getOwnerId()
Same as account.getAccountId(). For compatible v1.x.

## account.getKeyId()
Return the ali key id.

## account.getGA() & account.setGA(bGA:boolean)
Gets or Sets the status of google analytics collection.
Set `bGA` to `true` for enabling google analytics, while set to `false` for disabling google analytics.
See [Privacy Policy](#privacy-policy).

## account.getHttps() & account.setHttps(bHttps:boolean)
Gets or Sets using `http` or `https` protocol.
Set `bHttps` to `true` for using `https`, while set to `false` for using `http` protocol.
Default is `false` for using `http` protocol.
