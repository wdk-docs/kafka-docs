# Msg

## Msg(msg: string, priority?:number, delaySeconds?:number)
A simple message define, used in MQBatch.

msg: string. The content of message.

priority: number, optional. 1(lowest)~16(highest), default is 8.

delaySeconds: number, optional. How many seconds will the messages be visible after sent. 0~604800(7days), default is 0.
This argument is prior to the options.DelaySeconds in attributes of message queue.
```javascript
var msg = new AliMNS.Msg("Make a test");
```

## msg.getMsg()
Return the content of message.

## msg.getPriority()
Return the priority of message.

## msg.getDelaySeconds()
Return the delay seconds of message.