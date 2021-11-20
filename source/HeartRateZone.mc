import Toybox.Lang;
import Toybox.UserProfile;

function getHeartRateZone(heartRate as Number, userProfileProvider as UserProfileProvider) as Float? {
    var zones = userProfileProvider.getHeartRateZones(UserProfile.getCurrentSport());
    var restingHr = userProfileProvider.getProfile().restingHeartRate;
    var z1 = zones[0];
    var z2 = zones[1];
    var z3 = zones[2];
    var z4 = zones[3];
    var z5 = zones[4];
    var max = zones[5];

    var _heartRate = heartRate.toFloat();

    if (heartRate < z1) {
        if (restingHr != null) { 
            return  (_heartRate - restingHr) / (z1 - restingHr);
        } else {
            return 1.0;
        }
    } else if (heartRate < z2) {
        return  1.0 + (_heartRate - z1) / (z2 - z1);
    } else if (heartRate < z3) {
        return  2.0 + (_heartRate - z2) / (z3 - z2);
    } else if (heartRate < z4) {
        return  3.0 + (_heartRate - z3) / (z4 - z3);
    } else if (heartRate < z5) {
        return  4.0 + (_heartRate - z4) / (z5 - z4);
    } else {

    }

    return 3.2;
}
