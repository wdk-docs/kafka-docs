��    .      �              �  �   �  7  �  �     �   �     L     R     V     Z     _     c     i     l     p     u     y     ~     �     �     �     �     �     �     �     �     �     �     �     �     �     �     �     �     �     �     �     �     �  `         a     {  s   �     �       7   1     i  {  p  �   �	  7  �
  �   �  �   �     ;     A     E     I     N     R     X     [     _     d     h     m     s     v     z     }     �     �     �     �     �     �     �     �     �     �     �     �     �     �     �     �     �  `   �     P     j  s   w     �       7         X   **流量峰值：** 写或读流量峰值，流量分为双通道，读写一致。购买时请按最大的为准。如写流量的峰值 100MB/s，读流量的峰值 300MB/s，则以 300MB/s 规格购买。 **消息保留的最长时间：** 是指在磁盘容量充足的情况下，消息的最长保留时间。在磁盘容量不足（即磁盘水位达到 85%）时，系统将提前删除旧的消息，以确保服务可用性。消息保留的最长时间默认为 72 小时，可选 24 小时 ～ 168 小时。 **磁盘容量：** 数据默认为 3 副本存储。如选择 300G 磁盘，由于 3 副本缘故，实际存储业务的磁盘大小为 100G，其余为备份容量。 **计费规格：** 购买规格按照流量峰值与磁盘容量两个维度计算。任何规格下的 Topic 个数与接口调用次数不另外收费。 1,584 100 120 1350 160 2,284 20 200 2100 250 2700 3,284 30 300 35 3600 4,166 450 4500 5,066 5,966 5400 60 6600 7,266 750 8,466 9,666 90 SSD 云盘 产品定价 价格（元/月） 您还可以在以上规格的基础上，自定义增加磁盘的容量，收费规则如下： 收费（元/月/100GB） 注意事项 注意：消息队列 Kafka 默认支持 3 副本，但购买时仅以实际业务（即单副本）流量计算。 流量峰值吞吐（MB/s） 消息存储空间 (GB) 消息队列 Kafka 提供以下基本规格与价格： 磁盘 Project-Id-Version: kafka docs 
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
 **流量峰值：** 写或读流量峰值，流量分为双通道，读写一致。购买时请按最大的为准。如写流量的峰值 100MB/s，读流量的峰值 300MB/s，则以 300MB/s 规格购买。 **消息保留的最长时间：** 是指在磁盘容量充足的情况下，消息的最长保留时间。在磁盘容量不足（即磁盘水位达到 85%）时，系统将提前删除旧的消息，以确保服务可用性。消息保留的最长时间默认为 72 小时，可选 24 小时 ～ 168 小时。 **磁盘容量：** 数据默认为 3 副本存储。如选择 300G 磁盘，由于 3 副本缘故，实际存储业务的磁盘大小为 100G，其余为备份容量。 **计费规格：** 购买规格按照流量峰值与磁盘容量两个维度计算。任何规格下的 Topic 个数与接口调用次数不另外收费。 1,584 100 120 1350 160 2,284 20 200 2100 250 2700 3,284 30 300 35 3600 4,166 450 4500 5,066 5,966 5400 60 6600 7,266 750 8,466 9,666 90 SSD 云盘 产品定价 价格（元/月） 您还可以在以上规格的基础上，自定义增加磁盘的容量，收费规则如下： 收费（元/月/100GB） 注意事项 注意：消息队列 Kafka 默认支持 3 副本，但购买时仅以实际业务（即单副本）流量计算。 流量峰值吞吐（MB/s） 消息存储空间 (GB) 消息队列 Kafka 提供以下基本规格与价格： 磁盘 