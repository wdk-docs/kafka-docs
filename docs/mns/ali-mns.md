# ali-mns (ali-mqs)
[![npm version](https://badge.fury.io/js/ali-mns.svg)](http://badge.fury.io/js/ali-mns)
[![npm version](https://badge.fury.io/js/ali-mqs.svg)](http://badge.fury.io/js/ali-mqs)

The nodejs sdk for aliyun mns service

[阿里云消息服务-简体中文-帮助手册](http://armclr.incars.com.cn/Links/AliMNS?lang=zh-Hans)

Ali MNS service is a MQ(message queue) service provided by AliYun.
The world largest online sales website www.taobao.com is heavily relying on it.

You can visit [http://www.aliyun.com/product/mns](http://www.aliyun.com/product/mns) for more details.

The original Ali-MQS service has been upgraded and changed it's name to Ali-MNS since June, 2015.
Go to  [Migrate](#migrate) part for the old version informations.

## 快速开始

Use 'npm install ali-mns' to install the package.

```javascript
    var AliMNS = require("ali-mns");
    var account = new AliMNS.Account("<your-account-id>", "<your-key-id>", "<your-key-secret>");
    var mq = new AliMNS.MQ("<your-mq-name>", account, "hangzhou");
    // send message
    mq.sendP("Hello ali-mns").then(console.log, console.error);
```
More sample codes can be found in [GitHub](https://github.com/InCar/ali-mns/tree/master/test).

## 许

The ali-mns use the [promise](https://www.npmjs.org/package/promise) pattern.
Any functions suffix with 'P' indicate a promise object will be returned from it.

## Typescript

If you only want to use it, forget this.

Most source files are written in typescript instead of javascript.
Visit [http://www.typescriptlang.org/](http://www.typescriptlang.org/) for more information about typescript.

If you interest in source file, visit GitHub [https://github.com/InCar/ali-mns](https://github.com/InCar/ali-mns)

Please use 'gulp' to compile ts files into a single index.js file after downloading source files.

## API参考

|类 | 方法 | 描述 |
|-|-|-|
| Account | [Account](#accountaccountidstring-keyidstring-keysecretstring) |*Account* 类存储您的ali帐户信息。 |
| | [getAccountId](#accountgetaccountid) |返回ali帐户ID |
| | [getOwnerId](#accountgetownerid) | 与account.getAccountId() 相同。,对于兼容的v1。 |
| | [getKeyId](#accountgetkeyid) | 返回ali密钥ID |
| | [getGA](#accountgetga--accountsetgabgaboolean) | 获取Google Analytics分析集的状态。 |
| | [setGA](#accountgetga--accountsetgabgaboolean) | 设置Google Analytics分析集的状态。 |
| Https | [getHttps](#accountgethttps--accountsethttpsbhttpsboolean) | 获取使用http或https协议。 |
| | [setHttps](#accountgethttps--accountsethttpsbhttpsboolean) | 使用http或https协议进行设置。 |
| Region | [Region](#regioncitystringcity-networkstringnetworktype-zonestringzone) | *Region* 类可帮助您指定数据中心的区域。 |
| | [toString](#regiontostring) | Convert region object to string value. |
| MNS | [MNS](#mnsaccountaccount-regionstringregion) [MQS](#mqsaccountaccount-regionstringregion) [MNSTopic](#mnstopicaccountaccount-regionstringregion) | 操作mns队列。 ,* MQS *用于兼容的v1.x. |
| | [listP](#mnslistpprefixstring-pagesizenumber-pagemarkerstring) | 列出数据中心中的所有队列。 |
| | [createP](#mnscreatepnamestring-optionsany) | 创建一个mq。 |
| | [deleteP](#mnsdeletepnamestring) | 删除mq。 |
| MQ | [MQ](#mqnamestring-accountaccount-regionstringregion) [MQBatch](#mqbatch) | *MQ* 在队列中操作消息。 |
| | [getName](#mqgetname) | 获取mq的名称。 |
| | [getAccount](#mqgetaccount) | 获取mq的帐户。 |
| | [getRegion](#mqgetregion) | 获取mq的区域。 |
| | [sendP](#mqsendpmsgstring-prioritynumber-delaysecondsnumber) | 将消息发送到队列。 |
| | [getRecvTolerance](#mqgetrecvtolerance--mqsetrecvtolerancevaluenumber) | 获取mq.recvP方法的容差秒数。 |
| | [setRecvTolerance](#mqgetrecvtolerance--mqsetrecvtolerancevaluenumber) | 设置mq.recvP方法的容差秒数。 |
| | [recvP](#mqrecvpwaitsecondsnumber) | 从队列接收消息。 |
| | [peekP](#mqpeekp) | 偷看一条消息。 |
| | [deleteP](#mqdeletepreceipthandlestring) | 从队列中删除消息。 |
| | [reserveP](#mqreservepreceipthandlestring-reservesecondsnumber) | 保留收到的消息。 |
| | [notifyRecv](#mqnotifyrecvcbexerror-msganyboolean-waitsecondsnumber) | 注册回调函数以接收消息。 |
| | [notifyStopP](#mqnotifystopp) | 停止mq.notifyRecv工作。 |
| | [getAttrsP](#mqgetattrsp) | 获取mq的属性。 |
| | [setAttrsP](#mqsetattrspoptionsany) | 修改mq的属性。 |
| MQBatch | [MQBatch](#mqbatch) | 提供2015年6月在Ali-MNS服务新版中引入的批处理模型。 |
| | [sendP](#mqbatchsendpmsgstring--array-prioritynumber-delaysecondsnumber) | 发送消息或批量发送消息到队列。 |
| | [recvP](#mqbatchrecvpwaitsecondsnumber-numofmessagesnumber) | 发送消息或批量发送消息到队列。 |
| | [peekP](#mqbatchpeekpnumofmessagesnumber) | 偷看消息。 |
| | [deleteP](#mqbatchdeletepreceipthandlestring--array) | 从队列中删除一条或多条消息。 |
| | [notifyRecv](#mqbatchnotifyrecvcbexerror-msganyboolean-waitsecondsnumber-numofmessagesnumber) | 注册回调函数以批量接收消息 |
| Msg | [Msg](#msgmsg-string-prioritynumber-delaysecondsnumber) | MQBatch中使用的简单消息定义。 |
| | [getMsg](#msggetmsg) | 返回消息内容。 |
| | [getPriority](#msggetpriority) | 返回消息的优先级。 |
| | [getDelaySeconds](#msggetdelayseconds) | 返回消息的延迟秒数。 |
| MNSTopic | [MNSTopic](#mnstopicaccountaccount-regionstringregion) | MNSTopic类扩展了类MNS，用于在主题模型中提供特征。 |
| | [listTopicP](#mnslisttopicpprefixstring-pagesizenumber-pagemarkerstring) | 列出所有主题 |
| | [createTopicP](#mnscreatetopicpnamestring-optionsany) | 创建一个主题。 |
| | [deleteTopicP](#mnsdeletetopicpnamestring) | 删除主题 |
| | [Topic](#topicnamestring-accountaccount-regionstringregion) | 操作主题 |
| | [getName](#topicgetname) | 获取主题名称。 |
| | [getAccount](#topicgetaccount) | 获取主题帐户。 |
| | [getRegion](#topicgetregion) | 获取主题区域。 |
| | [getAttrsP](#topicgetattrsp--topicsetattrspoptionsany) | 获取主题的属性。 |
| | [setAttrsP](#topicgetattrsp--topicsetattrspoptionsany) | 设置主题的属性。 |
| | [listP](#topiclistpprefixstring-pagesizenumber-pagemarkerstring) | 列出所有订阅。 |
| | [subscribeP](#topicsubscribepnamestring-endpointstring-notifystrategystring-notifycontentformatstring-filtertagstring) | 订阅主题。 |
| | [unsubscribeP](#topicunsubscribepnamestring) | 取消订阅主题。 |
| | [publishP](#topicpublishpmsgstring-b64boolean-tagstring-attrsany-optionsany) | 将消息发布到主题。 |
| Subscription | [Subscription](#subscriptionnamestring-topictopic) | 运营订阅。 |
| | [getName](#subscriptiongetname) | 获取订阅名称。 |
| | [getTopic](#subscriptiongettopic) | 获取订阅主题。 |
| | [getAttrsP](#subscriptiongetattrsp--subscriptionsetattrspoptionsany) | 获取订阅的属性。 |
| | [setAttrsP](#subscriptiongetattrsp--subscriptionsetattrspoptionsany) | 设置订阅的属性。 |
| | [NotifyStrategy](#subscriptionnotifystrategy) | NotifyStrategy常量。 |
| | [NotifyContentFormat](#subscriptionnotifycontentformat) | NotifyContentFormat常量 |

## 调试跟踪

将环境变量**DEBUG**设置为`ali-mns`以启用调试跟踪输出。

```SHELL
## linux bash
export DEBUG=ali-mns

## windows
set DEBUG=ali-mns
```

## 迁移

+ 1. ali-mns与ali-mqs完全兼容，只需将ali-mqs包替换为ali-mns即可。

```javascript
// var AliMQS = require('ali-mqs');
var AliMQS = require('ali-mns');
```

+ 2. 可选的。,将**ownerId**更改为**accountId**

Ali-Yun升级他们的帐户系统，并建议使用较新的帐户ID而不是所有者ID。
但是老主人身份现在仍然可用。

```javascript
var AliMQS = require("ali-mns");
// var account = new AliMNS.Account("hl35yqoedp", "<your-key-id>", "<your-key-secret>");
var account = new AliMNS.Account("1786090012649663", "<your-key-id>", "<your-key-secret>");
```
**ownerId** 与数字和字母混合在一起

**accountId** 是一个16位数字， 点击[此链接](https://account.console.aliyun.com/#/secure)查找您的accountId。

In GitHub, [An branch v1.x](https://github.com/InCar/ali-mns/tree/v1.x) keeps tracking for the old mqs services.
And use `npm install ali-mqs' to install the [ali-mqs](https://www.npmjs.com/package/ali-mqs) package for v1.x.

## 性能 - 串行与批量

创建20个队列，然后随机发送2000条消息。

它在串行模式下比在批处理模式下慢约**10倍**。

**1st - 串行模式(batch_size=1)**

```
// 20 queues 2000 messages batch_size=1
  AliMNS-performance
    concurrent-queues
      √ #BatchSend (3547ms)
      √ #recvP (21605ms)
      √ #stopRecv (6075ms)
```

**2nd - 批量调制(Batch_size=16)**

```
// 20 queues 2000 messages batch_size=16
  AliMNS-performance
    concurrent-queues
      √ #BatchSend (3472ms)
      √ #recvP (2125ms)
      √ #stopRecv (6044ms)
```

The testing code is in [$/test/performance.js](https://github.com/InCar/ali-mns/blob/master/test/performance.js)
and a test log sample is in [$/test/performance.log](https://github.com/InCar/ali-mns/blob/master/test/performance.log)

Use `npm run test` to execute the test.

Set environment variable **DEBUG** to **ali-mns.test** to turn on output trace(will slow down the test).

## 隐私政策

我们收集有关如何使用`ali-mns`包以获得更好服务的信息。

By default a tracing information is sent to google analytics when sending a request to ali-mns service, The tracing information contains only the url.
Your data, key will not be sent.
Your account id is sent by hash to md5 value, so it can not be used tracking back to you.
You can check [code](https://github.com/InCar/ali-mns/blob/master/ts/GA.ts#L28) about data collection.

您可以随时禁用数据收集。

```javascript
    var AliMNS = require("ali-mns");
    var account = new AliMNS.Account("<your-account-id>", "<your-key-id>", "<your-key-secret>");

    // Disable google analytics data collection
    account.setGA(false);

    var mq = new AliMNS.MQ("<your-mq-name>", account, "hangzhou");
    mq.sendP("Hello ali-mns").then(console.log, console.error);
```

## 证书

MIT