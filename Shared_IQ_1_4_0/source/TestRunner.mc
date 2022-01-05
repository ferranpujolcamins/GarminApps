import Toybox.Lang;
import Toybox.System;

(:debug)
module UnitTests {

    // A class that can be passed to unit tests so they can be run from your app instead of the unit tests app.
    class Logger {
        function debug(message as String) as Void {
            System.println(message);
        }
    }
}