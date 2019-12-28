概观
====

The ``node-rdkafka`` library is a high-performance NodeJS client for
`Apache Kafka <http://kafka.apache.org/>`__ that wraps the native
`librdkafka <https://github.com/edenhill/librdkafka>`__ library. All the
complexity of balancing writes across partitions and managing (possibly
ever-changing) brokers should be encapsulated in the library.

**This library currently uses ``librdkafka`` version ``0.11.4``.**

参考文档
--------

To view the reference docs for the current version, go
`here <https://blizzard.github.io/node-rdkafka/current/>`__

特约
----

For guidelines on contributing please see
`CONTRIBUTING.md <https://github.com/blizzard/node-rdkafka/blob/master/CONTRIBUTING.md>`__

行为准则
--------

Play nice; Play fair.

要求
----

-  Apache Kafka >=0.9
-  Node.js >=4
-  Linux/Mac
-  Windows?! See below
-  openssl 1.0.2

Mac OS High Sierra
~~~~~~~~~~~~~~~~~~

OpenSSL has been upgraded in High Sierra and homebrew does not overwrite
default system libraries. That means when building node-rdkafka, because
you are using openssl, you need to tell the linker where to find it:

.. code:: sh

   export CPPFLAGS=-I/usr/local/opt/openssl/include
   export LDFLAGS=-L/usr/local/opt/openssl/lib

Then you can run ``npm install`` on your application to get it to build
correctly.

**NOTE:** From the ``librdkafka`` docs

   WARNING: Due to a bug in Apache Kafka 0.9.0.x, the ApiVersionRequest
   (as sent by the client when connecting to the broker) will be
   silently ignored by the broker causing the request to time out after
   10 seconds. This causes client-broker connections to stall for 10
   seconds during connection-setup before librdkafka falls back on the
   broker.version.fallback protocol features. The workaround is to
   explicitly configure api.version.request to false on clients
   communicating with <=0.9.0.x brokers.

Alpine
~~~~~~

Using Alpine Linux? Check out the
`docs <https://github.com/Blizzard/node-rdkafka/blob/master/examples/docker-alpine.md>`__.

Windows
~~~~~~~

Installing ``node-rdkafka`` on Windows is now possible thanks to
`#248 <https://github.com/Blizzard/node-rdkafka/pull/248>`__. However,
it does require some special instructions.

You can read the `Librdkafka Windows
Instructions <https://github.com/edenhill/librdkafka/blob/master/README.win32>`__
here. As it says in that document, you must be using Microsoft Visual
Studio 2013 to compile ``librdkafka``. This is because a version of
openssl that is used requires this version of Visual Studio.

If you have multiple versions of Visual Studio on your machine you may
need to ensure that the correct MSBuild is called by node-gyp. For
whatever reason, gyp just uses the MSBuild in your path if there is one,
so you will need to ensure it resolves to the right place. The ``bin``
directory for MSBuild will usually be similar to
``C:/Program Files (x86)/MSBuild/12.0/Bin/`` so ensure it comes late in
your path.

Additionally, ``librdkafka`` requires a few dependencies be installed
via ``nuget`` before it will build properly on Windows. You will need to
`download the nuget command line
tools <https://www.nuget.org/downloads>`__ and make sure ``nuget.exe``
is available in your path. It is recommended that you install the latest
stable version, as versions before ``v4.3.0`` did not always correctly
read dependencies.

Lastly, you may need to set the MS build tools gyp uses to the correct
version.

.. code:: sh

   node-gyp configure --msvs_version=2013

After that it should compile!

**Note:** I *still* do not recommend using ``node-rdkafka`` in
production on Windows. This feature was in high demand and is provided
to help develop, but we do not test against Windows, and windows support
may lag behind Linux/Mac support because those platforms are the ones
used to develop this library. Contributors are welcome if any Windows
issues are found :)

测试
----

This project includes two types of unit tests in this project: \*
end-to-end integration tests \* unit tests

You can run both types of tests by using ``Makefile``. Doing so calls
``mocha`` in your locally installed ``node_modules`` directory.

-  Before you run the tests, be sure to init and update the submodules:

   1. ``git submodule init``
   2. ``git submodule update``

-  To run the unit tests, you can run ``make lint`` or ``make test``.
-  To run the integration tests, you must have a running Kafka
   installation available. By default, the test tries to connect to
   ``localhost:9092``; however, you can supply the ``KAFKA_HOST``
   environment variable to override this default behavior. Run
   ``make e2e``.
