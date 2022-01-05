import Toybox.Lang;
import Toybox.Math;
import Toybox.System;

module Shared_IQ_1_4_0 {
    
    (:Format)
    module Format {
        
        // Prints minutes and seconds (00:00) from a number of minutes.
        function minutesAndSecondsFromMinutes(value as Double) as String {
            var minutes = Math.floor(value).toNumber();
            var seconds = Math.round(((value - minutes) * 60)).toNumber();
            return Lang.format("$1$:$2$", [ minutes, seconds.format("%02u") ]);
        }
    }
}