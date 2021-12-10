import Toybox.Lang;
import Toybox.System;

(:debug)
module UnitTest {
    class Logger {
        function debug(message as String) as Void {
            System.println(message);
        }
    }
}