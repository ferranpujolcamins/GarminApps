import Toybox.Lang;
import Toybox.System;

(:debug)
module UnitTests {
    class Logger {
        function debug(message as String) as Void {
            System.println(message);
        }
    }
}