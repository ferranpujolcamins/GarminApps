import Toybox.Lang;
import Toybox.System;
import Shared_IQ_1_4_0.Assert;

module Shared_IQ_1_4_0 {
    
    (:Units)
    module Units {
        enum Unit {
            MetersPerSecond = "m/s",
            KmPerHour = "km/h",
            MinPerKm = "min/km",
            MinPerMile = "min/mi"
        }

        function toMetersPerSecond(value as Double, unit as Unit) as Double {
            switch (unit) {
                case MetersPerSecond:
                    return value;
                
                case KmPerHour:
                    return value * 1000 / 3600;

                case MinPerKm:
                    return 1 / (value * 60 / 1000);

                case MinPerMile:
                    return 1 / (value * 60 / 1609.344d);
                
                default:
                    Assert.that(false);
                    return 0.0d;
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

                case MinPerMile:
                    return 1 / (value * 60 / 1609.344d);

                default:
                    Assert.that(false);
                    return 0.0d;
            }
        }

        function convert(value as Double, from as Unit, to as Unit) as Double {
            if (from == to) {
                return value;
            }
            return fromMetersPerSecond(
                toMetersPerSecond(value, from),
                to
            );
        }
    }
}