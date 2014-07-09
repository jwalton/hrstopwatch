assert = require 'assert'
timeunit = require 'timeunit'
HRStopwatch = require '../src/index.coffee'

describe "stopwatch", ->
    it "should correctly record time for a second", (done) ->
        watch = new HRStopwatch()
        start = Date.now()

        timeunit.seconds.sleep 1, ->
            try
                end = Date.now()
                elapsedInMs = end - start
                measuredInMs = timeunit.nanoseconds.toMillis(watch.getTime())
                deltaInMs = elapsedInMs - measuredInMs
                assert(Math.abs(deltaInMs) < 10, "Delta should be less than 10ms, was #{deltaInMs}ms")
                done()
            catch err
                done err

    it "should be created stopped if 'start' is passed false", (done) ->
        watch = new HRStopwatch(start: false)

        timeunit.milliseconds.sleep 100, ->
            try
                assert.equal watch.getTime(), 0
                done()
            catch err
                done err

    it "should be stopped when reset() is called", (done) ->
        watch = new HRStopwatch()
        watch.reset()

        timeunit.milliseconds.sleep 100, ->
            try
                assert.equal watch.getTime(), 0
                done()
            catch err
                done err

