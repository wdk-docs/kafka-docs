# Subscription

## Subscription(name:string, topic:Topic)
Operate a subscription.
```javascript
var AliMNS = require("ali-mns");
var account = new AliMNS.Account("<your-account-id>", "<your-key-id>", "<your-key-secret>");
var topic = new AliMNS.Topic("t11", account, "shenzhen");
var subscription = new AliMNS.Subscription("s12", topic);
```

## subscription.getName()
Get name of subscription.

## subscription.getTopic()
Get topic of subscription.


## subscription.getAttrsP() & subscription.setAttrsP(options:any)
Get or set attributes of subscription.

options: attributes of subscription.

options.NotifyStrategy: BACKOFF_RETRY or EXPONENTIAL_DECAY_RETRY.
```javascript
subscription.setAttrsP({ NotifyStrategy: AliMNS.Subscription.NotifyStrategy.EXPONENTIAL_DECAY_RETRY });
```

## Subscription.NotifyStrategy
Contains 2 const string.

AliMNS.Subscription.NotifyStrategy.BACKOFF_RETRY : "BACKOFF_RETRY"

AliMNS.Subscription.NotifyStrategy.EXPONENTIAL_DECAY_RETRY : "EXPONENTIAL_DECAY_RETRY"

[More about NotifyStrategy[zh-Hans]](https://help.aliyun.com/document_detail/mns/api_reference/concepts/NotifyStrategy.html?spm=5176.docmns/api_reference/topic_api_spec/subscription_operation.6.141.tmwb5L)

## Subscription.NotifyContentFormat
Contains 2 const string.

AliMNS.Subscription.NotifyContentFormat.XML : "XML"

AliMNS.Subscription.NotifyContentFormat.SIMPLIFIED : "SIMPLIFIED"

[More about NotifyContentFormat[zh-Hans]](https://help.aliyun.com/document_detail/mns/api_reference/concepts/NotifyContentFormat.html?spm=5176.docmns/api_reference/concepts/NotifyStrategy.6.142.kWiFyy)
