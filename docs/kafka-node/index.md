Kafka-node
==========

[![Build Status](https://travis-ci.org/SOHU-Co/kafka-node.svg?branch=master)](https://travis-ci.org/SOHU-Co/kafka-node)
[![Coverage Status](https://coveralls.io/repos/github/SOHU-Co/kafka-node/badge.svg?branch=master)](https://coveralls.io/github/SOHU-Co/kafka-node?branch=master)

[![NPM](https://nodei.co/npm/kafka-node.png)](https://nodei.co/npm/kafka-node/)
<!--[![NPM](https://nodei.co/npm-dl/kafka-node.png?height=3)](https://nodei.co/npm/kafka-node/)-->


Kafka-node is a Node.js client with Zookeeper integration for Apache Kafka 0.8.1 and later.

# Table of Contents
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [Features](#features)
- [Install Kafka](#install-kafka)
- [API](#api)
    - [KafkaClient](#kafkaclient)
    - [Client](#client)
    - [Producer](#producer)
    - [HighLevelProducer](#highlevelproducer)
    - [ProducerStream](#producerstream)
    - [Consumer](#consumer)
    - [ConsumerStream](#consumerstream)
    - [HighLevelConsumer](#highlevelconsumer)
    - [ConsumerGroup](#consumergroup)
    - [ConsumerGroupStream](#consumergroupstream)
    - [Offset](#offset)
    - [Admin](#admin)
- [Troubleshooting / FAQ](#troubleshooting--faq)
    - [HighLevelProducer with KeyedPartitioner errors on first send](#highlevelproducer-with-keyedpartitioner-errors-on-first-send)
    - [How do I debug an issue?](#how-do-i-debug-an-issue)
    - [How do I get a list of all topics?](#how-do-i-get-a-list-of-all-topics)
    - [For a new consumer how do I start consuming from the latest message in a partition?](#for-a-new-consumer-how-do-i-start-consuming-from-the-latest-message-in-a-partition)
    - [FailedToRebalanceConsumerError: Exception: NODE_EXISTS[-110]](#failedtorebalanceconsumererror-exception-node_exists-110)
    - [HighLevelConsumer does not consume on all partitions](#highlevelconsumer-does-not-consume-on-all-partitions)
    - [How to throttle messages / control the concurrency of processing messages](#how-to-throttle-messages--control-the-concurrency-of-processing-messages)
    - [How do I produce and consume binary data?](#how-do-i-produce-and-consume-binary-data)
    - [What are these node-gyp and snappy errors?](#what-are-these-node-gyp-and-snappy-errors)
    - [How do I configure the log output?](#how-do-i-configure-the-log-output)
- [Running Tests](#running-tests)
- [LICENSE - "MIT"](#license---mit)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Features
* Consumer and High Level Consumer
* Producer and High Level Producer
* Node Stream Producer (Kafka 0.9+)
* Node Stream Consumers (ConsumerGroupStream Kafka 0.9+)
* Manage topic Offsets
* SSL connections to brokers (Kafka 0.9+)
* Consumer Groups managed by Kafka coordinator (Kafka 0.9+)
* Connect directly to brokers (Kafka 0.9+)
* Administrative APIs
	* List Groups
	* Describe Groups

# Install Kafka
Follow the [instructions](http://kafka.apache.org/documentation.html#quickstart) on the Kafka wiki to build Kafka 0.8 and get a test broker up and running.


# LICENSE - "MIT"
Copyright (c) 2015 Sohu.com

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.