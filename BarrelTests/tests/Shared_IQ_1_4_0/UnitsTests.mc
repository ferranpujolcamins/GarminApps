import Toybox.Lang;
import Toybox.Application;
import Toybox.Math;
import Toybox.Test;
import Shared_IQ_1_4_0.Units;

(:test)
function unitsTest(logger as Logger) as Boolean {
    return checkUnitsConversion(1.toDouble(), Units.MetersPerSecond, Units.MetersPerSecond, 1.toDouble(), logger)
        && checkUnitsConversion(1.toDouble(), Units.KmPerHour, Units.KmPerHour, 1.toDouble(), logger)
        && checkUnitsConversion(1.toDouble(), Units.MinPerKm, Units.MinPerKm, 1.toDouble(), logger)

        && checkUnitsConversion(1.toDouble(), Units.KmPerHour, Units.MetersPerSecond, 1000.toDouble()/3600, logger)
        && checkUnitsConversion(1.toDouble(), Units.MinPerKm, Units.MetersPerSecond, 1000.toDouble()/60, logger)

        && checkUnitsConversion(1.toDouble(), Units.MetersPerSecond, Units.KmPerHour, 3600.toDouble()/1000, logger)
        && checkUnitsConversion(1.toDouble(), Units.MetersPerSecond, Units.MinPerKm, 1000.toDouble()/60, logger)

        && checkUnitsConversion(5.toDouble(), Units.KmPerHour, Units.MinPerKm, 12.toDouble(), logger)
        && checkUnitsConversion(12.toDouble(), Units.MinPerKm, Units.KmPerHour, 5.toDouble(), logger)

        && checkUnitsConversion(5.toDouble(), Units.MetersPerSecond, Units.KmPerHour, 18.toDouble(), logger)
        && checkUnitsConversion(18.toDouble(), Units.KmPerHour, Units.MetersPerSecond, 5.toDouble(), logger)

        && checkUnitsConversion(5.toDouble(), Units.MetersPerSecond, Units.MinPerKm, 30.toDouble()/9, logger)
        && checkUnitsConversion(30.toDouble()/9, Units.MinPerKm, Units.MetersPerSecond, 5.toDouble(), logger);
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