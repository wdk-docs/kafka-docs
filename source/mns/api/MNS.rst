MNS
===

MNS(account:Account, region?:string|Region)
-------------------------------------------

The *MNS* operate the mns queue.

account: An account object.

region: String|Region, optional. If it is string, it can be “hangzhou”,
“beijing” or any Chinese datacenter city name. If it is Region, it
allows you to specify data center other than in China. Default is
“hangzhou”. It can also be internal or vpc address “hangzhou-internal”,
“beijing-internal” or “qingdao-internal-vpc”.

.. code:: javascript

       var AliMNS = require("ali-mns");
       var account = new AliMNS.Account("<your-account-id>", "<your-key-id>", "<your-key-secret>");
       var mns = new AliMNS.MNS(account, "hangzhou");
       // or
       var regionJapan = new AliMNS.Region(AliMNS.City.Japan, AliMNS.NetworkType.Public);
       var mnsJapan = new AliMNS.MNS(account, regionJapan);

MQS(account:Account, region?:string|Region)
-------------------------------------------

Same as MNS. For compatible v1.x.

mns.listP(prefix?:string, pageSize?:number, pageMarker?:string)
---------------------------------------------------------------

List all of the queue in a data center.

prefix: String, optional. Return only mq with the prefix.

pageSize: number, optional. How many mns will be returned in a page,
1~1000, default is 1000.

pageMarker: String, optional. Request the next page, the value is
returned in last call.

.. code:: javascript

       mns.listP("my", 20).then(function(data){
           console.log(data);
           return mns.listP("my", 20, data.Queues.NextMarker);
       }).then(function(dataP2){
           console.log(dataP2);
       }, console.error);

mns.createP(name:string, options?:any)
--------------------------------------

Create a mq.

name: String. The queue name.

options: optional. The queue attributes.

options.DelaySeconds: number. How many seconds will the messages be
visible after sent. 0~604800(7days), default is 0.

options.MaximumMessageSize: number. How many bytes could the message be.
1024(1k)~65536, default is 65536(64k).

options.MessageRetentionPeriod: number. How many seconds will the
messages live, 60~1296000(15days), default is 345600(4days).

optiions.VisibilityTimeout: number. How many seconds will the message
keep invisible after be received, 1~43200(12hours), default is 30.

options.PollingWaitSeconds: numer. How many seconds will the receive
request wait for if mq is empty. 0~30, default is 0.

.. code:: javascript

       mns.createP("myAliMQ", {
           DelaySeconds: 0,
           MaximumMessageSize: 65536,
           MessageRetentionPeriod: 345600,
           VisibilityTimeout: 30,
           PollingWaitSeconds: 0
       }).then(console.log, console.error);

If a mq with same name exists, calling createP will succeed only when
all of the mq attributes are all same. Any mismatched attributes will
cause an “QueueAlreadyExist” failure.

mns.deleteP(name:string)
------------------------

Delete an mq.

name: String. The queue name.

.. code:: javascript

       mns.deleteP("myAliMQ").then(console.log, console.error);;
