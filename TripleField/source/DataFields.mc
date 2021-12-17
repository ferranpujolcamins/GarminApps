import Toybox.Lang;
import Toybox.Activity;
import Toybox.Application;
import Toybox.UserProfile;
import Shared.CurrentWorkoutStepProviderModule;
import Shared.UserProfileProviderModule;
using Shared.HeartRateZones as Hr;
import Shared.Assert;

enum FieldId {
    None = 9999,

    HeartRate = 0,
    HRZone = 1,
    TargetHR = 2,
    TargetHRZone = 3,
    LoTargetHR = 4,
    HiTargetHR = 5,
    LoTargetHRZone = 6,
    HiTargetHRZone = 7,

   // Target = 3, shows the target value no matter what target type
   // TargetType = 4
}


class Field {
    function initialize(id as FieldId, value as Float?) {
        mId = id;
        mValue = value;
    }

    var mId as FieldId;
    var mValue as Float? = null;
}

class FieldValueProvider {

    function initialize(workoutStepProvider as CurrentWorkoutStepProvider,
                        userProfileProvider as UserProfileProvider,
                        info as Info) {
        mWorkoutStepProvider = workoutStepProvider;
        mUserProfileProvider = userProfileProvider;
        mInfo = info;
    }

    var mWorkoutStepProvider as CurrentWorkoutStepProvider;
    var mUserProfileProvider as UserProfileProvider;
    var mInfo as Info;

    function get(index as FieldId) as Float? {
        var workoutStep;
        var hrWorkoutTarget;
        var currentHeartRate = mInfo.currentHeartRate;
        switch(index) {
            case None:
                return null;

            case HeartRate:
                return currentHeartRate;

            case HRZone:
                if (currentHeartRate != null) {
                    return Hr.getHeartRateZone(currentHeartRate, mUserProfileProvider);
                } else {
                    return null;
                }

            case TargetHR:
                workoutStep = mWorkoutStepProvider.getCurrentWorkoutStep();
                if (workoutStep == null) { return null; }

                hrWorkoutTarget = HrWorkoutTarget.isTargetHr(workoutStep);
                if (hrWorkoutTarget == null) { return null; }

                if (hrWorkoutTarget.isZone()) {
                    var zone = hrWorkoutTarget.getZone().toFloat();
                    var lowHr = Hr.getHeartRate(zone, mUserProfileProvider);
                    var hiHr = Hr.getHeartRate(zone + 1, mUserProfileProvider);
                    if (lowHr == null || hiHr == null) {
                        return null;
                    }
                    return (lowHr + hiHr) / 2.0;
                } else {
                    return ((hrWorkoutTarget.getValueLow() + hrWorkoutTarget.getValueHigh()) / 2).toFloat();
                }

            case TargetHRZone:
                workoutStep = mWorkoutStepProvider.getCurrentWorkoutStep();
                if (workoutStep == null) { return null; }

                hrWorkoutTarget = HrWorkoutTarget.isTargetHr(workoutStep);
                if (hrWorkoutTarget == null) { return null; }

                if (hrWorkoutTarget.isZone()) {
                    return hrWorkoutTarget.getZone().toFloat();
                } else {
                    var bpm = (hrWorkoutTarget.getValueLow() + hrWorkoutTarget.getValueHigh()) / 2;
                    return Hr.getHeartRateZone(bpm, mUserProfileProvider);
                }

            case LoTargetHR:
                workoutStep = mWorkoutStepProvider.getCurrentWorkoutStep();
                if (workoutStep == null) { return null; }

                hrWorkoutTarget = HrWorkoutTarget.isTargetHr(workoutStep);
                if (hrWorkoutTarget == null) { return null; }

                if (hrWorkoutTarget.isZone()) {
                    var zone = hrWorkoutTarget.getZone().toFloat();
                    var lowHr = Hr.getHeartRate(zone, mUserProfileProvider);
                    if (lowHr == null) {
                        return null;
                    }
                    return lowHr.toFloat();
                } else {
                    return hrWorkoutTarget.getValueLow().toFloat();
                }

            case HiTargetHR:
                workoutStep = mWorkoutStepProvider.getCurrentWorkoutStep();
                if (workoutStep == null) { return null; }

                hrWorkoutTarget = HrWorkoutTarget.isTargetHr(workoutStep);
                if (hrWorkoutTarget == null) { return null; }

                if (hrWorkoutTarget.isZone()) {
                    var zone = hrWorkoutTarget.getZone().toFloat();
                    var hiHr = Hr.getHeartRate(zone + 1, mUserProfileProvider);
                    if (hiHr == null) {
                        return null;
                    }
                    return hiHr.toFloat();
                } else {
                    return hrWorkoutTarget.getValueHigh().toFloat();
                }

            case LoTargetHRZone:
                workoutStep = mWorkoutStepProvider.getCurrentWorkoutStep();
                if (workoutStep == null) { return null; }

                hrWorkoutTarget = HrWorkoutTarget.isTargetHr(workoutStep);
                if (hrWorkoutTarget == null) { return null; }

                if (hrWorkoutTarget.isZone()) {
                    return hrWorkoutTarget.getZone().toFloat();
                } else {
                    return Hr.getHeartRateZone(hrWorkoutTarget.getValueLow(), mUserProfileProvider);
                }

            case HiTargetHRZone:
                workoutStep = mWorkoutStepProvider.getCurrentWorkoutStep();
                if (workoutStep == null) { return null; }

                hrWorkoutTarget = HrWorkoutTarget.isTargetHr(workoutStep);
                if (hrWorkoutTarget == null) { return null; }

                if (hrWorkoutTarget.isZone()) {
                    if (hrWorkoutTarget.getZone() >= 5) {
                        return 5.9;
                    }
                    return hrWorkoutTarget.getZone() + 1.0;
                } else {
                    return Hr.getHeartRateZone(hrWorkoutTarget.getValueHigh(), mUserProfileProvider);
                }

            default:
                Assert.that(false);
                return null;
        }
    }
}

function getFieldName(index as FieldId) as String {
    switch(index) {
        case HeartRate:
            return Application.loadResource(Rez.Strings.HeartRateLabel);
        case HRZone:
            return Application.loadResource(Rez.Strings.HeartRateZoneLabel);
        case TargetHR:
            return Application.loadResource(Rez.Strings.TargetHeartRateLabel);
        case TargetHRZone:
            return Application.loadResource(Rez.Strings.TargetHeartRateZoneLabel);
        case LoTargetHR:
            return Application.loadResource(Rez.Strings.LowTargetHeartRateLabel);
        case HiTargetHR:
            return Application.loadResource(Rez.Strings.HighTargetHeartRateLabel);
        case LoTargetHRZone:
            return Application.loadResource(Rez.Strings.LowTargetHeartRateZoneLabel);
        case HiTargetHRZone:
            return Application.loadResource(Rez.Strings.HighTargetHeartRateZoneLabel);

        default:
            Assert.that(false);
            return "?";
    }
}

class HrWorkoutTarget {
    hidden var mWorkoutStep as WorkoutStep;

    function initialize(workoutStep as WorkoutStep) {
        mWorkoutStep = workoutStep;
    }

    static function isTargetHr(workoutStep as WorkoutStep) as HrWorkoutTarget? {
        if (workoutStep.targetType != Activity.WORKOUT_STEP_TARGET_HEART_RATE) {
            return null;
        }
        return new HrWorkoutTarget(workoutStep);
    }

    function isZone() as Boolean {
        return mWorkoutStep.targetValueLow < 100;
    }

    function getZone() as Number {
        return mWorkoutStep.targetValueLow;
    }

    function getValueLow() as Number {
        // There seems to be a bug in connectIQ that sets these values 100 too high.
        return mWorkoutStep.targetValueLow - 100;
    }

    function getValueHigh() as Number {
        // There seems to be a bug in connectIQ that sets these values 100 too high.
        return mWorkoutStep.targetValueHigh - 100;
    }
}