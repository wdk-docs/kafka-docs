# MNSTopic

## MNSTopic(account:Account, region?:string|Region)
The class `MNSTopic` extends class `MNS` for providing features in topic model.
All methods in `MNS` class are also available in `MNSTopic`.
```javascript
    var AliMNS = require("ali-mns");
    var account = new AliMNS.Account("<your-account-id>", "<your-key-id>", "<your-key-secret>");
    var mns = new AliMNS.MNSTopic(account, "shenzhen");
    // or
    var regionJapan = new AliMNS.Region(AliMNS.City.Japan, AliMNS.NetworkType.Public);
    var mnsJapan = new AliMNS.MNSTopic(account, regionJapan);
```

## mns.listTopicP(prefix?:string, pageSize?:number, pageMarker?:string)
List all topics.

prefix: String, optional. Return only topics with the prefix.

pageSize: number, optional. How many topics will be returned in a page, 1~1000, default is 1000.

pageMarker: String, optional. Request the next page, the value is returned in last call.

## mns.createTopicP(name:string, options?:any)
Create a topic.

name: topic name.

options: optional.

options.MaximumMessageSize: int. The maximum size of message, 1024(1k)~65536(64k), default is 65536.

options.LoggingEnabled: boolean. Enable logging or not, default is false.

## mns.deleteTopicP(name:string)
Delete a topic.

name: topic name.

## Topic(name:string, account:Account, region?:string|Region)
Operate a topic.

name: topic name.

account: An account object.

region: String|Region, optional.
If it is string, it can be "hangzhou", "beijing" or any Chinese datacenter city name.
If it is Region, it allows you to specify data center other than in China.
Default is "hangzhou". It can also be internal or vpc address "hangzhou-internal", "beijing-internal" or "qingdao-internal-vpc".
```javascript
    var AliMNS = require("ali-mns");
    var account = new AliMNS.Account("<your-account-id>", "<your-key-id>", "<your-key-secret>");
    var topic = new AliMNS.Topic("t11", account, "shenzhen");
    // or
    var regionJapan = new AliMNS.Region(AliMNS.City.Japan, AliMNS.NetworkType.Public);
    var topicJapan = new AliMNS.Topic("t11", account, regionJapan);
```

## topic.getName()
Get topic name.

## topic.getAccount()
Get topic account.

## topic.getRegion()
Get topic region.

## topic.getAttrsP() & topic.setAttrsP(options:any)
Get or set attributes of topic.

options: topic attributes.

options.MaximumMessageSize: int. The maximum size of message, 1024(1k)~65536(64k), default is 65536.

options.LoggingEnabled: boolean. Enable logging or not, default is false.

```javascript
topic.setAttrsP({ MaximumMessageSize: 1024 });
topic.getAttrsP().then((data)=>{ console.info(data); });
```

## topic.listP(prefix?:string, pageSize?:number, pageMarker?:string)
List all subscriptions.

prefix: String, optional. Return only subscriptions with the prefix.

pageSize: number, optional. How many subscriptions will be returned in a page, 1~1000, default is 1000.

pageMarker: String, optional. Request the next page, the value is returned in last call.

## topic.subscribeP(name:string, endPoint:string, notifyStrategy?:string, notifyContentFormat?:string, filterTag?:string)
Subscribe a topic.

name: Name of subscription.

endPoint: Notify end point. eg. `http://www.yoursite.com/mns-ep`

notifyStrategy: optional. BACKOFF_RETRY or EXPONENTIAL_DECAY_RETRY, default is BACKOFF_RETRY.

notifyContentFormat: optional. XML or SIMPLIFIED, default is XML.

filterTag: Optional. Only matched messages will be pushed the endPoint, max length is 16; default is *undefined*, do not filter out any messages.

```javascript
topic.subscribeP("subx", "http://www.yoursite.com/mns-ep",
        AliMNS.Subscription.NotifyStrategy.BACKOFF_RETRY,
        AliMNS.Subscription.NotifyContentFormat.SIMPLIFIED)
    .then(
        (data)=>{ console.info(data);},
        (err)=>{ console.error(err); }
    );
```

## topic.unsubscribeP(name:string)
Unsubscribe a topic.

name: Name of subscription.

## topic.publishP(msg:string, b64:boolean, tag?:string, attrs?:any, options?:any)
Publish a message to a topic.

msg: content of message

b64: true, encoding msg to base64 format before publishing.
false, do not encoding msg before publishing.

tag: the TAG of message.

attrs: attribures of message.

options: options for the [request](https://www.npmjs.com/package/request#requestoptions-callback) underlying.

If message contains Chinese characters, must set `b64` to `true`.
Only very simple message can set `b64` to `false`.

Set options to `{ forever: true }` will let http(s) channel *KeepAive*.


