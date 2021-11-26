import Toybox.Lang;
import Toybox.System;

(:debug)
module UnitTest {
    class Logger {
        function debug(message as String) as Void {
            System.println(message);
        }
    }

    function runTests() as Void {
        var logger = new Logger() as Toybox.Test.Logger;

        //var result = testTargetHrZoneIsSingleHrTargetZone(logger);
        //System.println(result);
    }
}