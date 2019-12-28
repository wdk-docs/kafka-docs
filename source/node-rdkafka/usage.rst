用法
====

You can install the ``node-rdkafka`` module like any other module:

::

   npm install node-rdkafka

To use the module, you must ``require`` it.

.. code:: js

   var Kafka = require('node-rdkafka');

组态
----

You can pass many configuration options to ``librdkafka``. A full list
can be found in ``librdkafka``\ ’s
`Configuration.md <https://github.com/edenhill/librdkafka/blob/0.11.1.x/CONFIGURATION.md>`__

Configuration keys that have the suffix ``_cb`` are designated as
callbacks. Some of these keys are informational and you can choose to
opt-in (for example, ``dr_cb``). Others are callbacks designed to return
a value, such as ``partitioner_cb``.

Not all of these options are supported. The library will throw an error
if the value you send in is invalid.

The library currently supports the following callbacks: \*
``partitioner_cb`` \* ``dr_cb`` or ``dr_msg_cb`` \* ``event_cb``

Librdkafka方法
~~~~~~~~~~~~~~

This library includes two utility functions for detecting the status of
your installation. Please try to include these when making issue reports
where applicable.

You can get the features supported by your compile of ``librdkafka`` by
reading the variable “features” on the root of the ``node-rdkafka``
object.

.. code:: js

   const Kafka = require('node-rdkafka');
   console.log(Kafka.features);

   // #=> [ 'gzip', 'snappy', 'ssl', 'sasl', 'regex', 'lz4' ]

You can also get the version of ``librdkafka``

.. code:: js

   const Kafka = require('node-rdkafka');
   console.log(Kafka.librdkafkaVersion);

   // #=> 0.11.1

发送消息
--------

A ``Producer`` sends messages to Kafka. The ``Producer`` constructor
takes a configuration object, as shown in the following example:

.. code:: js

   var producer = new Kafka.Producer({
     'metadata.broker.list': 'kafka-host1:9092,kafka-host2:9092'
   });

A ``Producer`` requires only ``metadata.broker.list`` (the Kafka
brokers) to be created. The values in this list are separated by commas.
For other configuration options, see the
`Configuration.md <https://github.com/edenhill/librdkafka/blob/0.11.1.x/CONFIGURATION.md>`__
file described previously.

The following example illustrates a list with several ``librdkafka``
options set.

.. code:: js

   var producer = new Kafka.Producer({
     'client.id': 'kafka',
     'metadata.broker.list': 'localhost:9092',
     'compression.codec': 'gzip',
     'retry.backoff.ms': 200,
     'message.send.max.retries': 10,
     'socket.keepalive.enable': true,
     'queue.buffering.max.messages': 100000,
     'queue.buffering.max.ms': 1000,
     'batch.num.messages': 1000000,
     'dr_cb': true
   });

流API
^^^^^

You can easily use the ``Producer`` as a writable stream immediately
after creation (as shown in the following example):

.. code:: js

   // Our producer with its Kafka brokers
   // This call returns a new writable stream to our topic 'topic-name'
   var stream = Kafka.Producer.createWriteStream({
     'metadata.broker.list': 'kafka-host1:9092,kafka-host2:9092'
   }, {}, {
     topic: 'topic-name'
   });

   // Writes a message to the stream
   var queuedSuccess = stream.write(new Buffer('Awesome message'));

   if (queuedSuccess) {
     console.log('We queued our message!');
   } else {
     // Note that this only tells us if the stream's queue is full,
     // it does NOT tell us if the message got to Kafka!  See below...
     console.log('Too many messages in our queue already');
   }

   stream.on('error', function (err) {
     // Here's where we'll know if something went wrong sending to Kafka
     console.error('Error in our kafka stream');
     console.error(err);
   })

If you do not want your code to crash when an error happens, ensure you
have an ``error`` listener on the stream. Most errors are not
necessarily fatal, but the ones that are will immediately destroy the
stream. If you use ``autoClose``, the stream will close itself at the
first sign of a problem.

标准API
^^^^^^^

The Standard API is more performant, particularly when handling high
volumes of messages. However, it requires more manual setup to use. The
following example illustrates its use:

.. code:: js

   var producer = new Kafka.Producer({
     'metadata.broker.list': 'localhost:9092',
     'dr_cb': true
   });

   // Connect to the broker manually
   producer.connect();

   // Wait for the ready event before proceeding
   producer.on('ready', function() {
     try {
       producer.produce(
         // Topic to send the message to
         'topic',
         // optionally we can manually specify a partition for the message
         // this defaults to -1 - which will use librdkafka's default partitioner (consistent random for keyed messages, random for unkeyed messages)
         null,
         // Message to send. Must be a buffer
         new Buffer('Awesome message'),
         // for keyed messages, we also specify the key - note that this field is optional
         'Stormwind',
         // you can send a timestamp here. If your broker version supports it,
         // it will get added. Otherwise, we default to 0
         Date.now(),
         // you can send an opaque token here, which gets passed along
         // to your delivery reports
       );
     } catch (err) {
       console.error('A problem occurred when sending our message');
       console.error(err);
     }
   });

   // Any errors we encounter, including connection errors
   producer.on('event.error', function(err) {
     console.error('Error from producer');
     console.error(err);
   })

To see the configuration options available to you, see the
`Configuration <#configuration>`__ section.

方法
''''

+----------------------------+-----------------------------------------+
| Method                     | Description                             |
+============================+=========================================+
| ``producer.connect()``     | Connects to the broker. The             |
|                            | ``connect()`` method emits the          |
|                            | ``ready`` event when it connects        |
|                            | successfully. If it does not, the error |
|                            | will be passed through the callback.    |
+----------------------------+-----------------------------------------+
| ``producer.disconnect()``  | Disconnects from the broker. The        |
|                            | ``disconnect()`` method emits the       |
|                            | ``disconnected`` event when it has      |
|                            | disconnected. If it does not, the error |
|                            | will be passed through the callback.    |
+----------------------------+-----------------------------------------+
| ``producer.poll()``        | Polls the producer for delivery reports |
|                            | or other events to be transmitted via   |
|                            | the emitter. In order to get the events |
|                            | in ``librdkafka``\ ’s queue to emit,    |
|                            | you must call this regularly.           |
+----------------------------+-----------------------------------------+
| ``producer.setPollInterval | Polls the producer on this interval,    |
| (interval)``               | handling disconnections and             |
|                            | reconnection. Set it to 0 to turn it    |
|                            | off.                                    |
+----------------------------+-----------------------------------------+
| ``producer.produce(topic,  | Sends a message. The ``produce()``      |
| partition, msg, key, times | method throws when produce would return |
| tamp, opaque)``            | an error. Ordinarily, this is just if   |
|                            | the queue is full.                      |
+----------------------------+-----------------------------------------+
| ``producer.flush(timeout,  | Flush the librdkafka internal queue,    |
| callback)``                | sending all messages. Default timeout   |
|                            | is 500ms                                |
+----------------------------+-----------------------------------------+

活动
''''

Some configuration properties that end in ``_cb`` indicate that an event
should be generated for that option. You can either:

-  provide a value of ``true`` and react to the event
-  provide a callback function directly

The following example illustrates an event:

.. code:: js

   var producer = new Kafka.Producer({
     'client.id': 'my-client', // Specifies an identifier to use to help trace activity in Kafka
     'metadata.broker.list': 'localhost:9092', // Connect to a Kafka instance on localhost
     'dr_cb': true // Specifies that we want a delivery-report event to be generated
   });

   // Poll for events every 100 ms
   producer.setPollInterval(100);

   producer.on('delivery-report', function(err, report) {
     // Report of delivery statistics here:
     //
     console.log(report);
   });

The following table describes types of events.

+----------------------------+-----------------------------------------+
| Event                      | Description                             |
+============================+=========================================+
| ``disconnected``           | The ``disconnected`` event is emitted   |
|                            | when the broker has disconnected. This  |
|                            | event is emitted only when              |
|                            | ``.disconnect`` is called. The wrapper  |
|                            | will always try to reconnect otherwise. |
+----------------------------+-----------------------------------------+
| ``ready``                  | The ``ready`` event is emitted when the |
|                            | ``Producer`` is ready to send messages. |
+----------------------------+-----------------------------------------+
| ``event``                  | The ``event`` event is emitted when     |
|                            | ``librdkafka`` reports an event (if you |
|                            | opted in via the ``event_cb`` option).  |
+----------------------------+-----------------------------------------+
| ``event.log``              | The ``event.log`` event is emitted when |
|                            | logging events come in (if you opted    |
|                            | into logging via the ``event_cb``       |
|                            | option). You will need to set a value   |
|                            | for ``debug`` if you want to send       |
|                            | information.                            |
+----------------------------+-----------------------------------------+
| ``event.stats``            | The ``event.stats`` event is emitted    |
|                            | when ``librdkafka`` reports stats (if   |
|                            | you opted in by setting the             |
|                            | ``statistics.interval.ms`` to a         |
|                            | non-zero value).                        |
+----------------------------+-----------------------------------------+
| ``event.error``            | The ``event.error`` event is emitted    |
|                            | when ``librdkafka`` reports an error    |
+----------------------------+-----------------------------------------+
| ``event.throttle``         | The ``event.throttle`` event emitted    |
|                            | when ``librdkafka`` reports throttling. |
+----------------------------+-----------------------------------------+
| ``delivery-report``        | The ``delivery-report`` event is        |
|                            | emitted when a delivery report has been |
|                            | found via polling. To use this event,   |
|                            | you must set ``request.required.acks``  |
|                            | to ``1`` or ``-1`` in topic             |
|                            | configuration and ``dr_cb`` (or         |
|                            | ``dr_msg_cb`` if you want the report to |
|                            | contain the message payload) to         |
|                            | ``true`` in the ``Producer``            |
|                            | constructor options.                    |
+----------------------------+-----------------------------------------+

Kafka.KafkaConsumer
-------------------

To read messages from Kafka, you use a ``KafkaConsumer``. You
instantiate a ``KafkaConsumer`` object as follows:

.. code:: js

   var consumer = new Kafka.KafkaConsumer({
     'group.id': 'kafka',
     'metadata.broker.list': 'localhost:9092',
   }, {});

The first parameter is the global config, while the second parameter is
the topic config that gets applied to all subscribed topics. To view a
list of all supported configuration properties, see the
`Configuration.md <https://github.com/edenhill/librdkafka/blob/master/CONFIGURATION.md>`__
file described previously. Look for the ``C`` and ``*`` keys.

The ``group.id`` and ``metadata.broker.list`` properties are required
for a consumer.

再平衡
~~~~~~

Rebalancing is managed internally by ``librdkafka`` by default. If you
would like to override this functionality, you may provide your own
logic as a rebalance callback.

.. code:: js

   var consumer = new Kafka.KafkaConsumer({
     'group.id': 'kafka',
     'metadata.broker.list': 'localhost:9092',
     'rebalance_cb': function(err, assignment) {

       if (err.code === Kafka.CODES.ERRORS.ERR__ASSIGN_PARTITIONS) {
         // Note: this can throw when you are disconnected. Take care and wrap it in
         // a try catch if that matters to you
         this.assign(assignment);
       } else if (err.code == Kafka.CODES.ERRORS.ERR__REVOKE_PARTITIONS){
         // Same as above
         this.unassign();
       } else {
         // We had a real error
         console.error(err);
       }

     }
   })

``this`` is bound to the ``KafkaConsumer`` you have created. By
specifying a ``rebalance_cb`` you can also listen to the ``rebalance``
event as an emitted event. This event is not emitted when using the
internal ``librdkafka`` rebalancer.

提交
~~~~

When you commit in ``node-rdkafka``, the standard way is to queue the
commit request up with the next ``librdkafka`` request to the broker.
When doing this, there isn’t a way to know the result of the commit.
Luckily there is another callback you can listen to to get this
information

.. code:: js

   var consumer = new Kafka.KafkaConsumer({
     'group.id': 'kafka',
     'metadata.broker.list': 'localhost:9092',
     'offset_commit_cb': function(err, topicPartitions) {

       if (err) {
         // There was an error committing
         console.error(err);
       } else {
         // Commit went through. Let's log the topic partitions
         console.log(topicPartitions);
       }

     }
   })

``this`` is bound to the ``KafkaConsumer`` you have created. By
specifying an ``offset_commit_cb`` you can also listen to the
``offset.commit`` event as an emitted event. It also has an error
parameter and a list of topic partitions. This is not emitted unless
opted in.

消息结构
~~~~~~~~

Messages that are returned by the ``KafkaConsumer`` have the following
structure.

.. code:: js

   {
     value: new Buffer('hi'), // message contents as a Buffer
     size: 2, // size of the message, in bytes
     topic: 'librdtesting-01', // topic the message comes from
     offset: 1337, // offset the message was read from
     partition: 1, // partition the message was on
     key: 'someKey', // key of the message if present
     timestamp: 1510325354780 // timestamp of message creation
   }

.. _流api-1:

流API
~~~~~

The stream API is the easiest way to consume messages. The following
example illustrates the use of the stream API:

.. code:: js

   // Read from the librdtesting-01 topic... note that this creates a new stream on each call!
   var stream = KafkaConsumer.createReadStream(globalConfig, topicConfig, {
     topics: ['librdtesting-01']
   });

   stream.on('data', function(message) {
     console.log('Got message');
     console.log(message.value.toString());
   });

You can also get the ``consumer`` from the streamConsumer, for using
consumer methods. The following example illustrates that:

.. code:: js

   stream.consumer.commit(); // Commits all locally stored offsets

.. _标准api-1:

标准API
~~~~~~~

You can also use the Standard API and manage callbacks and events
yourself. You can choose different modes for consuming messages:

-  *Flowing mode*. This mode flows all of the messages it can read by
   maintaining an infinite loop in the event loop. It only stops when it
   detects the consumer has issued the ``unsubscribe`` or ``disconnect``
   method.
-  *Non-flowing mode*. This mode reads a single message from Kafka at a
   time manually.

The following example illustrates flowing mode:

.. code:: js

   // Flowing mode
   consumer.connect();

   consumer
     .on('ready', function() {
       consumer.subscribe(['librdtesting-01']);

       // Consume from the librdtesting-01 topic. This is what determines
       // the mode we are running in. By not specifying a callback (or specifying
       // only a callback) we get messages as soon as they are available.
       consumer.consume();
     })
     .on('data', function(data) {
       // Output the actual message contents
       console.log(data.value.toString());
     });

The following example illustrates non-flowing mode:

.. code:: js

   // Non-flowing mode
   consumer.connect();

   consumer
     .on('ready', function() {
       // Subscribe to the librdtesting-01 topic
       // This makes subsequent consumes read from that topic.
       consumer.subscribe(['librdtesting-01']);

       // Read one message every 1000 milliseconds
       setInterval(function() {
         consumer.consume(1);
       }, 1000);
     })
     .on('data', function(data) {
       console.log('Message found!  Contents below.');
       console.log(data.value.toString());
     });

The following table lists important methods for this API.

+-------------------------------------+------------------------------------------+
|               Method                |               Description                |
+=====================================+==========================================+
| ``consumer.connect()``              | Connects to the broker. The              |
|                                     | ``connect()`` emits the event ``ready``  |
|                                     | when it has successfully connected. If   |
|                                     | it does not, the error will be passed    |
|                                     | through the callback.                    |
+-------------------------------------+------------------------------------------+
| ``consumer.disconnect()``           | Disconnects from the broker. The         |
|                                     | ``disconnect()`` method emits            |
|                                     | ``disconnected`` when it has             |
|                                     | disconnected. If it does not, the error  |
|                                     | will be passed through the callback.     |
+-------------------------------------+------------------------------------------+
| ``consumer.subscribe(topic          | Subscribes to an array of topics.        |
| s)``                                |                                          |
+-------------------------------------+------------------------------------------+
| ``consumer.unsubscribe()``          | Unsubscribes from the currently          |
|                                     | subscribed topics. You cannot subscribe  |
|                                     | to different topics without calling the  |
|                                     | ``unsubscribe()`` method first.          |
+-------------------------------------+------------------------------------------+
| ``consumer.consume(cb)``            | Gets messages from the existing          |
|                                     | subscription as quickly as possible.     |
|                                     | This method keeps a background thread    |
|                                     | running to do the work. If ``cb`` is     |
|                                     | specified, invokes                       |
|                                     | ``cb(err, message)``.                    |
+-------------------------------------+------------------------------------------+
| ``consumer.consume(number,cb)``     | Gets ``number`` of messages from the     |
|                                     | existing subscription. If ``cb`` is      |
|                                     | specified, invokes ``cb(err, message)``. |
+-------------------------------------+------------------------------------------+
| ``consumer.commit()``               | Commits all locally stored offsets       |
+-------------------------------------+------------------------------------------+
| ``consumer.commit(topicPartition)`` | Commits offsets specified by the topic   |
|                                     | partition                                |
+-------------------------------------+------------------------------------------+
| ``consumer.commitMessage(message)`` | Commits the offsets specified by the     |
|                                     | message                                  |
+-------------------------------------+------------------------------------------+

The following table lists events for this API.

+----------------------------+-----------------------------------------+
| Event                      | Description                             |
+============================+=========================================+
| ``data``                   | When using the Standard API consumed    |
|                            | messages are emitted in this event.     |
+----------------------------+-----------------------------------------+
| ``disconnected``           | The ``disconnected`` event is emitted   |
|                            | when the broker disconnects. This event |
|                            | is only emitted when ``.disconnect`` is |
|                            | called. The wrapper will always try to  |
|                            | reconnect otherwise.                    |
+----------------------------+-----------------------------------------+
| ``ready``                  | The ``ready`` event is emitted when the |
|                            | ``Consumer`` is ready to read messages. |
+----------------------------+-----------------------------------------+
| ``event``                  | The ``event`` event is emitted when     |
|                            | ``librdkafka`` reports an event (if you |
|                            | opted in via the ``event_cb`` option).  |
+----------------------------+-----------------------------------------+
| ``event.log``              | The ``event.log`` event is emitted when |
|                            | logging events occur (if you opted in   |
|                            | for logging via the ``event_cb``        |
|                            | option). You will need to set a value   |
|                            | for ``debug`` if you want information   |
|                            | to send.                                |
+----------------------------+-----------------------------------------+
| ``event.stats``            | The ``event.stats`` event is emitted    |
|                            | when ``librdkafka`` reports stats (if   |
|                            | you opted in by setting the             |
|                            | ``statistics.interval.ms`` to a         |
|                            | non-zero value).                        |
+----------------------------+-----------------------------------------+
| ``event.throttle``         | The ``event.throttle`` event is emitted |
|                            | when ``librdkafka`` reports throttling. |
+----------------------------+-----------------------------------------+

从主体中读取代理的当前偏移量
----------------------------

Some times you find yourself in the situation where you need to know the
latest (and earliest) offset for one of your topics. Connected producers
and consumers both allow you to query for these through
``queryWaterMarkOffsets`` like follows:

.. code:: js

   var timeout = 5000, partition = 0;
   consumer.queryWatermarkOffsets('my-topic', partition, timeout, function(err, offsets) {
     var high = offsets.highOffset;
     var low = offsets.lowOffset;
   });

   producer.queryWatermarkOffsets('my-topic', partition, timeout, function(err, offsets) {
     var high = offsets.highOffset;
     var low = offsets.lowOffset;
   });

   An error will be returned if the client was not connected or the request timed out within the specified interval.

元数据
------

Both ``Kafka.Producer`` and ``Kafka.KafkaConsumer`` include a
``getMetadata`` method to retrieve metadata from Kafka.

Getting metadata on any connection returns the following data structure:

.. code:: js

   {
     orig_broker_id: 1,
     orig_broker_name: "broker_name",
     brokers: [
       {
         id: 1,
         host: 'localhost',
         port: 40
       }
     ],
     topics: [
       {
         name: 'awesome-topic',
         partitions: [
           {
             id: 1,
             leader: 20,
             replicas: [1, 2],
             isrs: [1, 2]
           }
         ]
       }
     ]
   }

The following example illustrates how to use the ``getMetadata`` method.

When fetching metadata for a specific topic, if a topic reference does
not exist, one is created using the default config. Please see the
documentation on ``Client.getMetadata`` if you want to set configuration
parameters, e.g. \ ``acks``, on a topic to produce messages to.

.. code:: js

   var opts = {
     topic: 'librdtesting-01',
     timeout: 10000
   };

   producer.getMetadata(opts, function(err, metadata) {
     if (err) {
       console.error('Error getting metadata');
       console.error(err);
     } else {
       console.log('Got metadata');
       console.log(metadata);
     }
   });
