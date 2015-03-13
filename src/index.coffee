# High resolution stopwatch.
module.exports = class Stopwatch
    hrtimeDiffToNanos = (diff) -> diff[0] * 1e9 + diff[1]

    # Parameters:
    # * `options.start` - If false, then watch will be created in a stopped state.  All calls
    #   to `getTime()` will return 0 until `start()` is called.  Defaults to true, which is like
    #   creating a Stopwatch and calling start immediately.
    constructor: (options={}) ->
        @reset()
        if(options.start ? true) then @start()

    # Reset this stopwatch.
    # `getTime()` will return 0 until the next call to `start()`.
    reset: ->
        @accumulator = 0
        @lastTime = null

    # Start a stopped stopwatch.  If `stop()` has not been called, this has no effect.
    start: ->
        if !@lastTime? then @lastTime = process.hrtime()

    # Stop a stopwatch.  Returns the total running time of the stopwatch in nanoseconds.
    stop: ->
        if @lastTime?
            diff = process.hrtime(@lastTime)
            @accumulator += hrtimeDiffToNanos diff
            @lastTime = null
        return @accumulator

    # Get the elapsed time of the stopwatch in nanoseconds.  If the stopwatch is stopped, this will
    # return the same value as the last call to `stop()`.
    getTime: ->
        if @lastTime?
            diff = process.hrtime(@lastTime)
            return @accumulator + hrtimeDiffToNanos diff
        else
            return @accumulator

    # Format the elapsed time of the stopwatch in a human-readable format
    format: ->
        return @formatDuration @getTime()

    # An alias to the format() method
    toString: ->
        return @format()

    # Format the supplied duration (in nanoseconds) in a human-readable format
    formatDuration: (nanos) ->
        if nanos >= 3600000000000
            minutes = nanos / 60000000000
            return Math.floor(minutes / 60) + " h, " + Math.floor(minutes % 60) + " min"

        if nanos >= 60000000000
            seconds = nanos / 1000000000
            return Math.floor(seconds / 60) + " min, " + Math.floor(seconds % 60) + " s"

        if nanos >= 1000000000
            millis = nanos / 1000000
            return Math.floor(millis / 1000) + "." + @zPad(Math.floor(millis % 1000)) + " s"

        if nanos >= 1000000
            micros = nanos / 1000
            return Math.floor(micros / 1000) + "." + @zPad(Math.floor(micros % 1000)) + " ms"

        return Math.floor(nanos / 1000) + "." + @zPad(Math.floor(nanos % 1000)) + " us"

    # Pad value with zeros to at most three places
    zPad: (value) ->
        if value < 10
            return "00" + value
        if value < 100
            return "0" + value
        return "" + value

