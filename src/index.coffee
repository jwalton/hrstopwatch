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