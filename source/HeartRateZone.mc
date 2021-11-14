import Toybox.Lang;
import Toybox.UserProfile;

function getHeartRateZone() as Float? {
    var z = UserProfile.getHeartRateZones(UserProfile.getCurrentSport());
    return 3.2;
}