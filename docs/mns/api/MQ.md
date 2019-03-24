# MQ

## MQ(name:string, account:Account, region?:string|Region)
The *MQ* operate the message in a queue.

name: String. The name of mq.

account: An account object.

region: String|Region, optional.
If it is string, it can be "hangzhou", "beijing" or any Chinese datacenter city name.
If it is Region, it allows you to specify data center other than in China.
Default is "hangzhou". It can also be internal or vpc address "hangzhou-internal", "beijing-internal" or "qingdao-internal-vpc".
```javascript
    var AliMNS = require("ali-mns");
    var account = new AliMNS.Account("<your-account-id>", "<your-key-id>", "<your-key-secret>");
    var mq = new AliMNS.MQ(account, "hangzhou");
    // or
    var regionJapan = new AliMNS.Region(AliMNS.City.Japan, AliMNS.NetworkType.Public);
    var mqJapan = new AliMNS.MQ(account, regionJapan);
```

## mq.getName()
Gets the name of mq.

## mq.getAccount()
Gets the account of mq.

## mq.getRegion()
Gets the region of mq.

## mq.sendP(msg:string, priority?:number, delaySeconds?:number)
Send a message to the queue.

message: String. The content that sent to queue.

priority: number, optional. 1(lowest)~16(highest), default is 8.

delaySeconds: number, optional. How many seconds will the messages be visible after sent. 0~604800(7days), default is 0.
This argument is prior to the options.DelaySeconds in attributes of message queue.
```javascript
    mq.sendP("Hello Ali-MNS", 8, 0).then(console.log, console.error);
```

## mq.getRecvTolerance() & mq.setRecvTolerance(value:number)
Gets or sets the tolerance seconds for mq.recvP method.

value: number. Default is 5, in seconds. How long will mq.recvP wait before timeout.
Due to network lag, the return of mq.recvP method may be later than expected.

## mq.recvP(waitSeconds?:number)
Receive a message from queue.
This will change the message to invisible for a while.

waitSeconds: number. optional.
The max seconds to wait if queue is empty, after that an error *MessageNotExist* will be returned.
```javascript
    mq.recvP(5).then(console.log, console.error);
```
This method will wait `waitSeconds + getRecvTolerance()` totally if queue is empty.

## mq.peekP()
Peek a message.
This will not change the message to invisible.
```javascript
    mq.peekP(5).then(console.log, console.error);
```

## mq.deleteP(receiptHandle:string)
Delete a message from queue.
A message will be invisible for a short time after received.
A message must be deleted after processed, otherwise it can be received again.

receiptHandle: String. Return by mq.recvP or mq.notifyRecv.
```javascript
    mq.recvP(5).then(function(data){
        return mq.deleteP(data.Message.ReceiptHandle);
    }).then(console.log, console.error);
```

## mq.reserveP(receiptHandle:string, reserveSeconds:number)
Reserve a received message.

receiptHandle: String. Return by mq.recvP or mq.notifyRecv.

reserveSeconds: number. How long will the message be reserved, in seconds. 1~43200(12hours).
```javascript
    mq.recvP().then(function(data){
            return mq.reserveP(data.Message.ReceiptHandle, 120);
    }).then(function(dataReserved){
            return mq.deleteP(dataReserved.ChangeVisibility.ReceiptHandle);
    });
```
If you need more time to process the message after received, you can reserve it for a longer time.
The message will continue to keep invisible for reserveSeconds from now.
Set a shorter time is also possible.
If succeed, a new receiptHandle will be returned to replace the old one, further mq.deleteP or mq.reserveP should use the newer.
And the newer receiptHandle will expired after reserveSeconds past.

## mq.notifyRecv(cb:(ex:Error, msg:any)=>Boolean, waitSeconds?:number)
Register a callback function to receive messages.

cb: The callback function will be called once for each received message.
And if the callback function return *true*, the message received will be delete automatically,
while you should delete the message manually, if return *false*.

waitSeconds: number, optional. 1~30. The max seconds to wait in a polling loop, default is 5.
At the begin of a polling loop, it will check if mq.notifyStopP has been called, So the bigger number
will cause a slowly mq.notifyStopP.
Set waitSeconds to 0 ,will actually use the default value 5 seconds instead.
```javascript
    mq.notifyRecv(function(err, message){
        console.log(message);
        if(err && err.message === "NetworkBroken"){
            // Best to restart the process when this occurs
            throw err;
        }
        return true; // this will cause message to be deleted automatically
    });
```

Both callback functions will work if you call notifyRecv twice for 2 different callback functions.
But each received message only will trigger one of them only.

## mq.notifyStopP()
Stop mq.notifyRecv working. The promise object returned will not be resolved until the receiving loop stopped actually.
The max time wait for notifyRecv() stop is determined by waitSeconds passed to mq.notifyRecv.
```javascript
    mq.notifyStopP().then(console.log, console.error);
```

## mq.getAttrsP()
Get the attributes of the mq.

    mq.getAttrsP().then(console.log, console.error);

## mq.setAttrsP(options:any)
Modify the attributes of mq.

options: the queue attributes. See the [options](#options) of mns.createP.
```javascript
    mq.setAttrsP({
        DelaySeconds: 0,
        MaximumMessageSize: 65536,
        MessageRetentionPeriod: 345600,
        VisibilityTimeout: 30,
        PollingWaitSeconds: 0
    }).then(console.log, console.error);
```