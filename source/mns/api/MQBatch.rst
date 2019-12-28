MQBatch
=======

Provide the batch process model introduced in a new edtion of Ali-MNS
service in June, 2015. It derives from MQ, so all methods in MQ are
avaiable in MQBatch too. For example, you can use
``mqBatch.setRecvTolerance(1.2)`` to adjust the timeout behavior of
*mqBatch.recvP()*.

.. code:: javascript

   var mqBatch = new AliMNS.MQBatch(aliCfg.mqName, account, aliCfg.region);

mqBatch.sendP(msg:string \| Array, priority?:number, delaySeconds?:number)
--------------------------------------------------------------------------

Send a message or batch send messages to the queue.

msg: String or an array of Msg. The message(s) up to 16 that sent to
queue.

priority: number, optional. Only valid when ``msg`` is a string,
1(lowest)~16(highest), default is 8.

delaySeconds: number, optional. Only valid when ``msg`` is a string. How
many seconds will the messages be visible after sent. 0~604800(7days),
default is 0. This argument is prior to the options.DelaySeconds in
attributes of message queue.

If ``msg`` is an array of ``Msg``, use the priority & delaySeconds
properties of ``Msg``, and ignore the 2nd and 3rd arguments.

.. code:: javascript

       var msgs = [];
       for(var i=0;i<5;i++){
           var msg = new AliMNS.Msg("BatchSend" + i, 8, 0);
           msgs.push(msg);
       }

       mqBatch.sendP(msgs);

mqBatch.recvP(waitSeconds?:number, numOfMessages?:number)
---------------------------------------------------------

Receive a message or batch receive messages from queue. This will change
the messages to invisible for a while.

waitSeconds: number. optional. The max seconds to wait if queue is
empty, after that an error *MessageNotExist* will be returned.

numOfMessages: number. optional. The max number of message can be
received in a batch, can be 1~16, default is 16.

.. code:: javascript

       mqBatch.recvP(5, 16).then(console.log, console.error);

mqBatch.peekP(numOfMessages?:number)
------------------------------------

Peek message(s). This will not change the message to invisible.

numOfMessages: number. optional. The max number of message can be peeked
in a batch, can be 1~16, default is 16.

.. code:: javascript

       mqBatch.peekP(5, 16).then(console.log, console.error);

mqBatch.deleteP(receiptHandle:string \| Array)
----------------------------------------------

Delete a message or messages from queue. Messages will be invisible for
a short time after received. Messages must be deleted after processed,
otherwise it can be received again.

receiptHandle: String or an array of string. Return by mq.recvP
mq.notifyRecv or mqBatch.recvP mqBatch.notifyRecv.

.. code:: javascript

       var rhsToDel = [];
       mqBatch.recvP(5, 16).then(function(dataRecv){
           for(var i=0;i<dataRecv.Messages.Message.length;i++){
               rhsToDel.push(dataRecv.Messages.Message[i].ReceiptHandle);
           }
       }).then(function(){
           return mqBatch.deleteP(rhsToDel);
       }).then(console.log, console.error);

mqBatch.notifyRecv(cb:(ex:Error, msg:any)=>Boolean, waitSeconds?:number, numOfMessages?:number)
-----------------------------------------------------------------------------------------------

Register a callback function to receive messages in batch mode.

numOfMessages: number. optional. The max number of message can be
received in a batch, can be 1~16, default is 16.

All other arguments are same as *mq.notifyRecv*.
