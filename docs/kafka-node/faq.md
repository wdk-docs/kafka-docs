# Troubleshooting / FAQ

## HighLevelProducer with KeyedPartitioner errors on first send

Error:

```
BrokerNotAvailableError: Could not find the leader
```

Call `client.refreshMetadata()` before sending the first message. Reference issue [#354](https://github.com/SOHU-Co/kafka-node/issues/354)



## How do I debug an issue?
This module uses the [debug module](https://github.com/visionmedia/debug) so you can just run below before starting your app.

```bash
export DEBUG=kafka-node:*
```

## How do I get a list of all topics?

Call `client.loadMetadataForTopics` with a blank topic array to get the entire list of available topics (and available brokers).

```js
client.once('connect', function () {
	client.loadMetadataForTopics([], function (error, results) {
	  if (error) {
	  	return console.error(error);
	  }
	  console.log('%j', _.get(results, '1.metadata'));
	});
});
```

## For a new consumer how do I start consuming from the latest message in a partition?

If you are using the new `ConsumerGroup` simply set `'latest'` to `fromOffset` option.

Otherwise:

1. Call `offset.fetchLatestOffsets` to get fetch the latest offset
2. Consume from returned offset

Reference issue [#342](https://github.com/SOHU-Co/kafka-node/issues/342)


## FailedToRebalanceConsumerError: Exception: NODE_EXISTS[-110]

This error can occur when a HLC is killed and restarted quickly. The ephemeral nodes linked to the previous session are not relinquished in zookeeper when `SIGINT` is sent and instead relinquished when zookeeper session timeout is reached. The timeout can be adjusted using the `sessionTimeout` zookeeper option when the `Client` is created (the default is 30000ms).

Example handler:

```js
process.on('SIGINT', function () {
    highLevelConsumer.close(true, function () {
        process.exit();
    });
});
```

Alternatively, you can avoid this issue entirely by omitting the HLC's `id` and a unique one will be generated for you.

Reference issue [#90](https://github.com/SOHU-Co/kafka-node/issues/90)

## HighLevelConsumer does not consume on all partitions

Your partition will be stuck if the `fetchMaxBytes` is smaller than the message produced.  Increase `fetchMaxBytes` value should resolve this issue.

Reference to issue [#339](https://github.com/SOHU-Co/kafka-node/issues/339)

## How to throttle messages / control the concurrency of processing messages

1. Create a `async.queue` with message processor and concurrency of one (the message processor itself is wrapped with `setImmediate` so it will not freeze up the event loop)
2. Set the `queue.drain` to resume the consumer
3. The handler for consumer's `message` event pauses the consumer and pushes the message to the queue.

## How do I produce and consume binary data?

### Consume
In the consumer set the `encoding` option to `buffer`.

### Produce
Set the `messages` attribute in the `payload` to a `Buffer`. `TypedArrays` such as `Uint8Array` are not supported and need to be converted to a `Buffer`.

```js
{
 messages: Buffer.from(data.buffer)
}
```

Reference to issue [#470](https://github.com/SOHU-Co/kafka-node/issues/470) [#514](https://github.com/SOHU-Co/kafka-node/issues/514)

## What are these node-gyp and snappy errors?

Snappy is a optional compression library. Windows users have reported issues with installing it while running `npm install`. It's **optional** in kafka-node and can be skipped by using the `--no-optional` flag (though errors from it should not fail the install).

```bash
npm install kafka-node --no-optional --save
```

Keep in mind if you try to use snappy without installing it `kafka-node` will throw a runtime exception.

## How do I configure the log output?

By default, `kafka-node` uses [debug](https://github.com/visionmedia/debug) to log important information. To integrate `kafka-node`'s log output into an application, it is possible to set a logger provider. This enables filtering of log levels and easy redirection of output streams.

### What is a logger provider?

A logger provider is a function which takes the name of a logger and returns a logger implementation. For instance, the following code snippet shows how a logger provider for the global `console` object could be written:

```javascript
function consoleLoggerProvider (name) {
  // do something with the name
  return {
    debug: console.debug.bind(console),
    info: console.info.bind(console),
    warn: console.warn.bind(console),
    error: console.error.bind(console)
  };
}
```

The logger interface with its `debug`, `info`, `warn` and `error` methods expects format string support as seen in `debug` or the JavaScript `console` object. Many commonly used logging implementations cover this API, e.g. bunyan, pino or winston.

### How do I set a logger provider?

For performance reasons, initialization of the `kafka-node` module creates all necessary loggers. This means that custom logger providers need to be set *before requiring the `kafka-node` module*. The following example shows how this can be done:

```javascript
// first configure the logger provider
const kafkaLogging = require('kafka-node/logging');
kafkaLogging.setLoggerProvider(consoleLoggerProvider);

// then require kafka-node and continue as normal
const kafka = require('kafka-node');
```