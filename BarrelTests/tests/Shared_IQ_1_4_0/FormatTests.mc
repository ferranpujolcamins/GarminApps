import Toybox.Lang;
import Toybox.Application;
import Toybox.Math;
import Toybox.Test;
import Shared_IQ_1_4_0.Format;

(:test)
function formatTest(logger as Logger) as Boolean {
    return checkMinutesAndSecondsFromMinutes(1.0d, "1:00", logger)
        && checkMinutesAndSecondsFromMinutes(1.1d, "1:06", logger)
        && checkMinutesAndSecondsFromMinutes(1.5d, "1:30", logger)
        && checkMinutesAndSecondsFromMinutes(1.9d, "1:54", logger)
        && checkMinutesAndSecondsFromMinutes(0.0d, "0:00", logger)
        && checkMinutesAndSecondsFromMinutes(0.9d, "0:54", logger)
        && checkMinutesAndSecondsFromMinutes(60.0d, "60:00", logger)
        && checkMinutesAndSecondsFromMinutes(6.0d, "6:00", logger)
        && checkMinutesAndSecondsFromMinutes(0.983333d, "0:59", logger)
        && checkMinutesAndSecondsFromMinutes(0.016666d, "0:01", logger);
}

(:debug)
function checkMinutesAndSecondsFromMinutes(value as Double, 
                                           expected as String,
                                           logger as Logger) as Boolean {
    var result = Format.minutesAndSecondsFromMinutes(value);
    if (!result.equals(expected)) {
        logger.debug("FAIL" + ": value = " + value + ", result = '" + result +"', expected = '" + expected + "'");
        return false;
    }
    return true;
}