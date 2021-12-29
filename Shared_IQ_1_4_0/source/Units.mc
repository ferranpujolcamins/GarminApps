import Toybox.Lang;
import Toybox.System;

module Shared_IQ_1_4_0 {
    
    (:Units)
    module Units {
        enum Unit {
            MetersPerSecond = "m/s",
            KmPerHour = "km/h",
            MinPerKm = "min/km"
        }

        function toMetersPerSecond(value as Double, unit as Unit) as Double {
            switch (unit) {
                case MetersPerSecond:
                    return value;
                
                case KmPerHour:
                    return value * 1000 / 3600;

                case MinPerKm:
                    return 1 / (value * 60 / 1000);
            }
        }

        function fromMetersPerSecond(value as Double, unit as Unit) as Double {
            switch (unit) {
                case MetersPerSecond:
                    return value;
                
                case KmPerHour:
                    return value * 3600 / 1000;

                case MinPerKm:
                    return 1 / (value * 60 / 1000);
            }
        }

        function convert(value as Double, from as Unit, to as Unit) as Double {
            if (from == to) {
                return value;
            }
            return fromMetersPerSecond(
                toMetersPerSecond(value.toDouble(), from),
                to
            );
        }
    }
}