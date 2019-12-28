Kafka-node
==========

|Build Status| |Coverage Status|

|NPM|

Kafka-node is a Node.js client with Zookeeper integration for Apache
Kafka 0.8.1 and later.

Table of Contents
=================

.. toctree::
   :maxdepth: 2
   :caption: Contents:

   api
   faq
   test

Features
========

-  Consumer and High Level Consumer
-  Producer and High Level Producer
-  Node Stream Producer (Kafka 0.9+)
-  Node Stream Consumers (ConsumerGroupStream Kafka 0.9+)
-  Manage topic Offsets
-  SSL connections to brokers (Kafka 0.9+)
-  Consumer Groups managed by Kafka coordinator (Kafka 0.9+)
-  Connect directly to brokers (Kafka 0.9+)
-  Administrative APIs

   -  List Groups
   -  Describe Groups

Install Kafka
=============

Follow the
`instructions <http://kafka.apache.org/documentation.html#quickstart>`__
on the Kafka wiki to build Kafka 0.8 and get a test broker up and
running.

LICENSE - “MIT”
===============

Copyright (c) 2015 Sohu.com

Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files (the
“Software”), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS
OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

.. |Build Status| image:: https://travis-ci.org/SOHU-Co/kafka-node.svg?branch=master
   :target: https://travis-ci.org/SOHU-Co/kafka-node
.. |Coverage Status| image:: https://coveralls.io/repos/github/SOHU-Co/kafka-node/badge.svg?branch=master
   :target: https://coveralls.io/github/SOHU-Co/kafka-node?branch=master
.. |NPM| image:: https://nodei.co/npm/kafka-node.png
   :target: https://nodei.co/npm/kafka-node/
