import Toybox.Lang;
import Toybox.Application;
import Toybox.Math;
import Toybox.Test;
import Shared_IQ_1_4_0.Units;

(:test)
function unitsTest(logger as Logger) as Boolean {
    return checkUnitsConversion(1d, Units.MetersPerSecond, Units.MetersPerSecond, 1d, logger)
        && checkUnitsConversion(1d, Units.KmPerHour, Units.KmPerHour, 1d, logger)
        && checkUnitsConversion(1d, Units.MinPerKm, Units.MinPerKm, 1d, logger)

        && checkUnitsConversion(1d, Units.KmPerHour, Units.MetersPerSecond, 1000d/3600, logger)
        && checkUnitsConversion(1d, Units.MinPerKm, Units.MetersPerSecond, 1000d/60, logger)

        && checkUnitsConversion(1d, Units.MetersPerSecond, Units.KmPerHour, 3600d/1000, logger)
        && checkUnitsConversion(1d, Units.MetersPerSecond, Units.MinPerKm, 1000d/60, logger)

        && checkUnitsConversion(5d, Units.KmPerHour, Units.MinPerKm, 12d, logger)
        && checkUnitsConversion(12d, Units.MinPerKm, Units.KmPerHour, 5d, logger)

        && checkUnitsConversion(5d, Units.MetersPerSecond, Units.KmPerHour, 18d, logger)
        && checkUnitsConversion(18d, Units.KmPerHour, Units.MetersPerSecond, 5d, logger)

        && checkUnitsConversion(5d, Units.MetersPerSecond, Units.MinPerKm, 30d/9, logger)
        && checkUnitsConversion(30d/9, Units.MinPerKm, Units.MetersPerSecond, 5d, logger);
}

(:debug)
function checkUnitsConversion(value as Double, 
                              from as Units.Unit, 
                              to as Units.Unit,
                              expected as Double,
                              logger as Logger) as Boolean {
    var result = Units.convert(value, from, to);
    if (result != expected) {
        logger.debug("FAIL" + ": value = " + value + ", result = " + result + ", from = " + from as String + ", to = " + to as String +", expected = " + expected);
        return false;
    }
    return true;
}