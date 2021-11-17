import Toybox.Lang;

class Counter {
    hidden var mCounter as Number;

    function initialize(ticks as Number) {
        if (ticks < 0) {
            throw new InvalidValueException("ticks must be non negative");
        }
        mCounter = ticks;
    }

    function tick() as Void {
        mCounter -= 1;
    }

    function done() as Boolean {
        return mCounter <= 0;
    }
}