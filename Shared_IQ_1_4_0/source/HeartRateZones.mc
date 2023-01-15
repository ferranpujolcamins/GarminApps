import Toybox.Lang;
import Toybox.Math;
import Toybox.UserProfile;
import Shared_IQ_1_4_0.UserProfileInterfaces;

module Shared_IQ_1_4_0 {
    
    (:HeartRateZones)
    module HeartRateZones {

        // Gets the decimal heart rate zone value corresponding to the given heart rate.
        function getHeartRateZone(heartRate as Float, userProfileProvider as UserProfileProvider) as Float {
            var zones = userProfileProvider.getHeartRateZones(UserProfile.getCurrentSport());
            var restingHr = userProfileProvider.getProfile().restingHeartRate;
            var z1 = zones[0];
            var z2 = zones[1];
            var z3 = zones[2];
            var z4 = zones[3];
            var z5 = zones[4];
            var maxHr = zones[5];

            var heartRateZone;

            if (heartRate < z1) {
                if (restingHr != null) { 
                    heartRateZone = (heartRate - restingHr) / (z1 - restingHr);
                    if (heartRateZone < 0) {
                        heartRateZone = 0.0;
                    }
                } else {
                    heartRateZone = 1.0;
                }
            } else if (heartRate < z2) {
                heartRateZone =  1.0 + (heartRate - z1) / (z2 - z1);
            } else if (heartRate < z3) {
                heartRateZone =  2.0 + (heartRate - z2) / (z3 - z2);
            } else if (heartRate < z4) {
                heartRateZone =  3.0 + (heartRate - z3) / (z4 - z3);
            } else if (heartRate < z5) {
                heartRateZone =  4.0 + (heartRate - z4) / (z5 - z4);
            } else {
                heartRateZone =  5.0 + (heartRate - z5) / (maxHr - z5);
                if (heartRateZone >= 6) {
                    heartRateZone = 5.9;
                }
            }

            // Round down to one decimal
            return (Math.floor(heartRateZone * 10) / 10).toFloat();
        }

        // Gets the heart rate value corresponding to the given decimal heart rate zone value.
        function getHeartRate(zone as Float, userProfileProvider as UserProfileProvider) as Number? {
            var zones = userProfileProvider.getHeartRateZones(UserProfile.getCurrentSport());
            var restingHr = userProfileProvider.getProfile().restingHeartRate;
            var z1 = zones[0];
            var z2 = zones[1];
            var z3 = zones[2];
            var z4 = zones[3];
            var z5 = zones[4];
            var maxHr = zones[5];

            var heartRate;
            if (zone < 1) {
                if (restingHr == null || zone < 0) { 
                    return null;
                }
                heartRate = zone * (z1 - restingHr) + restingHr;
            } else if (zone < 2) {
                heartRate = (zone - 1) * (z2 - z1) + z1;
            } else if (zone < 3) {
                heartRate = (zone - 2) * (z3 - z2) + z2;
            } else if (zone < 4) {
                heartRate = (zone - 3) * (z4 - z3) + z3;
            } else if (zone < 5) {
                heartRate = (zone - 4) * (z5 - z4) + z4;
            } else if (zone < 6) {
                heartRate = (zone - 5) * (maxHr - z5) + z5;
            } else {
                heartRate = maxHr;
            }
            return heartRate.toNumber();
        }

        // If the given heart rate range corresponds to a heart rate zone, returns the number of the zone.
        // Otherwise, returns null.
        function isHeartRateZone(lowHr as Number, highHr as Number, userProfileProvider as UserProfileProvider) as Number? {
            var zones = userProfileProvider.getHeartRateZones(UserProfile.getCurrentSport());
            for (var i = 0; i < zones.size() - 1; i++) {
                if (zones[i] == lowHr && zones[i + 1] == highHr) {
                    return i + 1;
                }
            }
            return null;
        }
    }
}
