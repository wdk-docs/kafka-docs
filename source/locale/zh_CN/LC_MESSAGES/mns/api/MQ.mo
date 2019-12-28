��    .      �              �  �   �  �   �     G  7   e     �     �     �  �  �     w  7   z     �  >   �  T     1   c     �     �  �   �  (   �  U   �     #	  �   ?	  �   (
  0   �
      %     F     V     e  9   r     �  C   �     �  
          8   9  <   r     �     �  M   �  @   5  ;   v  Z  �  \     �   j  4    �   B  {  �  �   @  �   �     �  7   �     �     �       �  $     �  7   �     �  >     T   Q  1   �     �     �  �     (   �  U        f  �   �  �   k  0   7      h     �     �     �  9   �     �  C   �     B  
   S     ^  8   |  <   �     �       M   *  @   x  ;   �  Z  �  \   P  �   �  4  P   �   �!   Both callback functions will work if you call notifyRecv twice for 2 different callback functions. But each received message only will trigger one of them only. Delete a message from queue. A message will be invisible for a short time after received. A message must be deleted after processed, otherwise it can be received again. Get the attributes of the mq. Gets or sets the tolerance seconds for mq.recvP method. Gets the account of mq. Gets the name of mq. Gets the region of mq. If you need more time to process the message after received, you can reserve it for a longer time. The message will continue to keep invisible for reserveSeconds from now. Set a shorter time is also possible. If succeed, a new receiptHandle will be returned to replace the old one, further mq.deleteP or mq.reserveP should use the newer. And the newer receiptHandle will expired after reserveSeconds past. MQ MQ(name:string, account:Account, region?:string|Region) Modify the attributes of mq. Peek a message. This will not change the message to invisible. Receive a message from queue. This will change the message to invisible for a while. Register a callback function to receive messages. Reserve a received message. Send a message to the queue. Stop mq.notifyRecv working. The promise object returned will not be resolved until the receiving loop stopped actually. The max time wait for notifyRecv() stop is determined by waitSeconds passed to mq.notifyRecv. The *MQ* operate the message in a queue. This method will wait ``waitSeconds + getRecvTolerance()`` totally if queue is empty. account: An account object. cb: The callback function will be called once for each received message. And if the callback function return *true*, the message received will be delete automatically, while you should delete the message manually, if return *false*. delaySeconds: number, optional. How many seconds will the messages be visible after sent. 0~604800(7days), default is 0. This argument is prior to the options.DelaySeconds in attributes of message queue. message: String. The content that sent to queue. mq.deleteP(receiptHandle:string) mq.getAccount() mq.getAttrsP() mq.getName() mq.getRecvTolerance() & mq.setRecvTolerance(value:number) mq.getRegion() mq.notifyRecv(cb:(ex:Error, msg:any)=>Boolean, waitSeconds?:number) mq.notifyStopP() mq.peekP() mq.recvP(waitSeconds?:number) mq.reserveP(receiptHandle:string, reserveSeconds:number) mq.sendP(msg:string, priority?:number, delaySeconds?:number) mq.setAttrsP(options:any) name: String. The name of mq. options: the queue attributes. See the `options <#options>`__ of mns.createP. priority: number, optional. 1(lowest)~16(highest), default is 8. receiptHandle: String. Return by mq.recvP or mq.notifyRecv. region: String|Region, optional. If it is string, it can be “hangzhou”, “beijing” or any Chinese datacenter city name. If it is Region, it allows you to specify data center other than in China. Default is “hangzhou”. It can also be internal or vpc address “hangzhou-internal”, “beijing-internal” or “qingdao-internal-vpc”. reserveSeconds: number. How long will the message be reserved, in seconds. 1~43200(12hours). value: number. Default is 5, in seconds. How long will mq.recvP wait before timeout. Due to network lag, the return of mq.recvP method may be later than expected. waitSeconds: number, optional. 1~30. The max seconds to wait in a polling loop, default is 5. At the begin of a polling loop, it will check if mq.notifyStopP has been called, So the bigger number will cause a slowly mq.notifyStopP. Set waitSeconds to 0 ,will actually use the default value 5 seconds instead. waitSeconds: number. optional. The max seconds to wait if queue is empty, after that an error *MessageNotExist* will be returned. Project-Id-Version: kafka docs 
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2019-07-23 14:46+0800
PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE
Last-Translator: FULL NAME <EMAIL@ADDRESS>
Language: zh_CN
Language-Team: zh_CN <LL@li.org>
Plural-Forms: nplurals=1; plural=0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Generated-By: Babel 2.6.0
 Both callback functions will work if you call notifyRecv twice for 2 different callback functions. But each received message only will trigger one of them only. Delete a message from queue. A message will be invisible for a short time after received. A message must be deleted after processed, otherwise it can be received again. Get the attributes of the mq. Gets or sets the tolerance seconds for mq.recvP method. Gets the account of mq. Gets the name of mq. Gets the region of mq. If you need more time to process the message after received, you can reserve it for a longer time. The message will continue to keep invisible for reserveSeconds from now. Set a shorter time is also possible. If succeed, a new receiptHandle will be returned to replace the old one, further mq.deleteP or mq.reserveP should use the newer. And the newer receiptHandle will expired after reserveSeconds past. MQ MQ(name:string, account:Account, region?:string|Region) Modify the attributes of mq. Peek a message. This will not change the message to invisible. Receive a message from queue. This will change the message to invisible for a while. Register a callback function to receive messages. Reserve a received message. Send a message to the queue. Stop mq.notifyRecv working. The promise object returned will not be resolved until the receiving loop stopped actually. The max time wait for notifyRecv() stop is determined by waitSeconds passed to mq.notifyRecv. The *MQ* operate the message in a queue. This method will wait ``waitSeconds + getRecvTolerance()`` totally if queue is empty. account: An account object. cb: The callback function will be called once for each received message. And if the callback function return *true*, the message received will be delete automatically, while you should delete the message manually, if return *false*. delaySeconds: number, optional. How many seconds will the messages be visible after sent. 0~604800(7days), default is 0. This argument is prior to the options.DelaySeconds in attributes of message queue. message: String. The content that sent to queue. mq.deleteP(receiptHandle:string) mq.getAccount() mq.getAttrsP() mq.getName() mq.getRecvTolerance() & mq.setRecvTolerance(value:number) mq.getRegion() mq.notifyRecv(cb:(ex:Error, msg:any)=>Boolean, waitSeconds?:number) mq.notifyStopP() mq.peekP() mq.recvP(waitSeconds?:number) mq.reserveP(receiptHandle:string, reserveSeconds:number) mq.sendP(msg:string, priority?:number, delaySeconds?:number) mq.setAttrsP(options:any) name: String. The name of mq. options: the queue attributes. See the `options <#options>`__ of mns.createP. priority: number, optional. 1(lowest)~16(highest), default is 8. receiptHandle: String. Return by mq.recvP or mq.notifyRecv. region: String|Region, optional. If it is string, it can be “hangzhou”, “beijing” or any Chinese datacenter city name. If it is Region, it allows you to specify data center other than in China. Default is “hangzhou”. It can also be internal or vpc address “hangzhou-internal”, “beijing-internal” or “qingdao-internal-vpc”. reserveSeconds: number. How long will the message be reserved, in seconds. 1~43200(12hours). value: number. Default is 5, in seconds. How long will mq.recvP wait before timeout. Due to network lag, the return of mq.recvP method may be later than expected. waitSeconds: number, optional. 1~30. The max seconds to wait in a polling loop, default is 5. At the begin of a polling loop, it will check if mq.notifyStopP has been called, So the bigger number will cause a slowly mq.notifyStopP. Set waitSeconds to 0 ,will actually use the default value 5 seconds instead. waitSeconds: number. optional. The max seconds to wait if queue is empty, after that an error *MessageNotExist* will be returned. 