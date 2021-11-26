import Toybox.Lang;
import Toybox.Test;
import Toybox.UserProfile;
import Shared.UserProfileProviderModule;
import Shared.UserProfileProviderTests;
using Shared.HeartRateZones as Hr;

module Shared {
    (:test)
    function testHeartRateZones(logger as Logger) as Boolean {
        var userProfileProvider = new MockUserProfileProvider();
        userProfileProvider.mZones = [120, 130, 140, 150, 160, 170] as Array<Number>;
        userProfileProvider.mProfile.restingHeartRate = 60;

        return checkHeartRateZone(50, 0.0, userProfileProvider, logger)
            && checkHeartRateZone(60, 0.0, userProfileProvider, logger)
            && checkHeartRateZone(90, 0.5, userProfileProvider, logger)
            && checkHeartRateZone(119, 0.9, userProfileProvider, logger)

            && checkHeartRateZone(120, 1.0, userProfileProvider, logger)
            && checkHeartRateZone(125, 1.5, userProfileProvider, logger)
            && checkHeartRateZone(129, 1.9, userProfileProvider, logger)

            && checkHeartRateZone(130, 2.0, userProfileProvider, logger)
            && checkHeartRateZone(135, 2.5, userProfileProvider, logger)
            && checkHeartRateZone(139, 2.9, userProfileProvider, logger)

            && checkHeartRateZone(140, 3.0, userProfileProvider, logger)
            && checkHeartRateZone(145, 3.5, userProfileProvider, logger)
            && checkHeartRateZone(149, 3.9, userProfileProvider, logger)

            && checkHeartRateZone(150, 4.0, userProfileProvider, logger)
            && checkHeartRateZone(155, 4.5, userProfileProvider, logger)
            && checkHeartRateZone(159, 4.9, userProfileProvider, logger)

            && checkHeartRateZone(160, 5.0, userProfileProvider, logger)
            && checkHeartRateZone(165, 5.5, userProfileProvider, logger)
            && checkHeartRateZone(169, 5.9, userProfileProvider, logger)
            && checkHeartRateZone(170, 5.9, userProfileProvider, logger)
            && checkHeartRateZone(171, 5.9, userProfileProvider, logger);
    }

    (:test)
    function testHeartRateZonesWithoutRestingHeartRate(logger as Logger) as Boolean {
        var userProfileProvider = new MockUserProfileProvider();
        userProfileProvider.mZones = [120, 130, 140, 150, 160, 170] as Array<Number>;
        userProfileProvider.mProfile.restingHeartRate = null;

        return checkHeartRateZone(50, 1.0, userProfileProvider, logger)
            && checkHeartRateZone(60, 1.0, userProfileProvider, logger)
            && checkHeartRateZone(90, 1.0, userProfileProvider, logger)
            && checkHeartRateZone(119, 1.0, userProfileProvider, logger)
            && checkHeartRateZone(120, 1.0, userProfileProvider, logger)
            && checkHeartRateZone(125, 1.5, userProfileProvider, logger)
            && checkHeartRateZone(129, 1.9, userProfileProvider, logger);
    }

    function checkHeartRateZone(heartRate as Number,
                                expectedZone as Float,
                                userProfileProvider as UserProfileProvider,
                                logger as Logger) as Boolean {
        var zone = Hr.getHeartRateZone(heartRate, userProfileProvider);
        var status = zone == expectedZone ? "PASS" : "FAIL";
        if (zone != expectedZone) {
            logger.debug(status + ": heartRate = " + heartRate + ", zone = " + zone + ", expectedZone = " + expectedZone);
        }
        return zone == expectedZone;
    }
}