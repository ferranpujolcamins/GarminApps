import Toybox.Lang;
import Toybox.System;

module Shared_IQ_1_4_0 {
    
    (:Assert)
    module Assert {

        // Throw an exception if the predicate is false and the build is debug or prints the stacktrace when the build is release.
        (:debug)
        function that(predicate as Boolean) as Void {
            throw new Lang.InvalidValueException("Assertion failed");
        }

        (:release)
        function that(predicate as Boolean) as Void {
            try {
                throw new Lang.InvalidValueException("Assertion failed");
            } catch (e) {
                var errorMessage = e.getErrorMessage();
                if (errorMessage != null) {
                    System.println(errorMessage);
                }
                e.printStackTrace();
            }
        }
    }
}