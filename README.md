[![NPM](https://nodei.co/npm/hrstopwatch.png?downloads=true&downloadRank=true&stars=true)](https://nodei.co/npm/hrstopwatch/)

HRStopwatch
===========

[![Greenkeeper badge](https://badges.greenkeeper.io/jwalton/hrstopwatch.svg)](https://greenkeeper.io/)

A stopwatch class built around [`process.hrtime()`](http://nodejs.org/api/process.html#process_process_hrtime),
with all the usual stopwatch methods like "start" and "stop".

About
=====

Yet another stopwatch class, but this one is more "complete" than others I found with a quick
search of npm.


Installation
============

    npm install --save hrstopwatch

Usage
=====

    HRStopwatch = require 'hrstopwatch'

    watch = new HRStopwatch()

    elapsed = watch.getTime() # Returns the time elapsed, in nanoseconds, since construction.

    elapsedStr = watch.format() # Return a human-readable string

    elapsed = watch.stop() # Pauses the stopwatch.  getTime() will now return the same value on
                           # subsequent calls until start() is called again.

    watch.start() # Restarts the stopwatch.  getTime() will not include any time that passed while
                  # the stopwatch was stopped.

    watch.reset() # Reset the stopwatch.  getTime() will return 0 until start() is called.


Compatibilty
============

Because `hrstopwatch` relies on `process.hrtime()`, it will work in node.js, but will not work
client side via [AMD/Require.js](http://requirejs.org/) and via [browersify](http://browserify.org/).
