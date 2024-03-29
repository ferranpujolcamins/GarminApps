import Toybox.Lang;
import Toybox.Test;
import Toybox.UserProfile;
import Shared_IQ_1_4_0.UserProfileInterfaces;
using Shared_IQ_1_4_0.UserProfileInterfaces.UnitTests as UnitTests;
using Shared_IQ_1_4_0.HeartRateZones as Hr;

(:test)
function testHeartRateZones(logger as Logger) as Boolean {
    var userProfileProvider = new UnitTests.MockUserProfileProvider();
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
    var userProfileProvider = new UnitTests.MockUserProfileProvider();
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

(:debug)
function checkHeartRateZone(heartRate as Number,
                            expectedZone as Float,
                            userProfileProvider as UserProfileProvider,
                            logger as Logger) as Boolean {
    var zone = Hr.getHeartRateZone(heartRate.toFloat(), userProfileProvider);
    if (zone != expectedZone) {
        logger.debug("FAIL" + ": heartRate = " + heartRate + ", zone = " + zone + ", expectedZone = " + expectedZone);
        return false;
    }
    return true;
}

(:test)
function testIsHeartRateZone(logger as Logger) as Boolean {
    var userProfileProvider = new UnitTests.MockUserProfileProvider();
    userProfileProvider.mZones = [120, 130, 140, 150, 160, 170] as Array<Number>;

    return checkIsHeartRateZone(120, 130, 1, userProfileProvider, logger)
        && checkIsHeartRateZone(130, 140, 2, userProfileProvider, logger)
        && checkIsHeartRateZone(140, 150, 3, userProfileProvider, logger)
        && checkIsHeartRateZone(150, 160, 4, userProfileProvider, logger)
        && checkIsHeartRateZone(160, 170, 5, userProfileProvider, logger)

        && checkIsHeartRateZone(120, 140, null, userProfileProvider, logger)
        && checkIsHeartRateZone(120, 120, null, userProfileProvider, logger)
        && checkIsHeartRateZone(130, 130, null, userProfileProvider, logger)
        && checkIsHeartRateZone(170, 170, null, userProfileProvider, logger)
        && checkIsHeartRateZone(110, 170, null, userProfileProvider, logger)
        && checkIsHeartRateZone(135, 145, null, userProfileProvider, logger)
        && checkIsHeartRateZone(110, 120, null, userProfileProvider, logger)
        && checkIsHeartRateZone(170, 175, null, userProfileProvider, logger);
}

(:debug)
function checkIsHeartRateZone(lowHr as Number, 
                              highHr as Number, 
                              expectedResult as Number?,
                              userProfileProvider as UserProfileProvider,
                              logger as Logger) as Boolean {
    var isHrZone = Hr.isHeartRateZone(lowHr, highHr, userProfileProvider);
    if (isHrZone != expectedResult) {
        logger.debug("FAIL" + ": lowHr = " + lowHr + ", highHr = " + highHr + ", isHrZone = " + asString(isHrZone) +", expected = " + asString(expectedResult));
        return false;
    }
    return true;
}

(:debug)
function asString(n as Number?) as String {
    if (n == null) {
        return "null";
    }
    return n.toString();
}