��          �               �   )   �        8        T  $   s     �  �   �     �     �     �  $   �  @   �  {    )   �     �  8   �       $   !     F  �   f     2     H     U  $   g  @   �   A simple message define, used in MQBatch. Msg Msg(msg: string, priority?:number, delaySeconds?:number) Return the content of message. Return the delay seconds of message. Return the priority of message. delaySeconds: number, optional. How many seconds will the messages be visible after sent. 0~604800(7days), default is 0. This argument is prior to the options.DelaySeconds in attributes of message queue. msg.getDelaySeconds() msg.getMsg() msg.getPriority() msg: string. The content of message. priority: number, optional. 1(lowest)~16(highest), default is 8. Project-Id-Version: kafka docs 
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
 A simple message define, used in MQBatch. Msg Msg(msg: string, priority?:number, delaySeconds?:number) Return the content of message. Return the delay seconds of message. Return the priority of message. delaySeconds: number, optional. How many seconds will the messages be visible after sent. 0~604800(7days), default is 0. This argument is prior to the options.DelaySeconds in attributes of message queue. msg.getDelaySeconds() msg.getMsg() msg.getPriority() msg: string. The content of message. priority: number, optional. 1(lowest)~16(highest), default is 8. 