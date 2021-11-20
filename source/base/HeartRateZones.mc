import Toybox.Lang;
import Toybox.Math;
import Toybox.UserProfile;

function getHeartRateZone(heartRate as Number, userProfileProvider as UserProfileProvider) as Float {
    var zones = userProfileProvider.getHeartRateZones(UserProfile.getCurrentSport());
    var restingHr = userProfileProvider.getProfile().restingHeartRate;
    var z1 = zones[0];
    var z2 = zones[1];
    var z3 = zones[2];
    var z4 = zones[3];
    var z5 = zones[4];
    var maxHr = zones[5];

    var _heartRate = heartRate.toFloat();
    var heartRateZone;

    if (heartRate < z1) {
        if (restingHr != null) { 
            heartRateZone = (_heartRate - restingHr) / (z1 - restingHr);
            if (heartRateZone < 0) {
                heartRateZone = 0;
            }
        } else {
            heartRateZone = 1.0;
        }
    } else if (heartRate < z2) {
        heartRateZone =  1.0 + (_heartRate - z1) / (z2 - z1);
    } else if (heartRate < z3) {
        heartRateZone =  2.0 + (_heartRate - z2) / (z3 - z2);
    } else if (heartRate < z4) {
        heartRateZone =  3.0 + (_heartRate - z3) / (z4 - z3);
    } else if (heartRate < z5) {
        heartRateZone =  4.0 + (_heartRate - z4) / (z5 - z4);
    } else {
        heartRateZone =  5.0 + (_heartRate - z5) / (maxHr - z5);
        if (heartRateZone >= 6) {
            heartRateZone = 5.9;
        }
    }

    // Round down to one decimal
    return Math.floor(heartRateZone * 10) / 10;
}
