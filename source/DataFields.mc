import Toybox.Lang;
import Toybox.Activity;
import Toybox.Application;
import Toybox.UserProfile;

enum FieldId {
    None = 9999,

    HeartRate = 0,
    HRZone = 1,
    TargetHR = 2,
    TargetHRZone = 3,

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
        var currentHeartRate = mInfo.currentHeartRate;
        switch(index) {
            case None:
                return null;
            case HeartRate:
                return currentHeartRate;
            case HRZone:
                if (currentHeartRate != null) {
                    return getHeartRateZone(currentHeartRate, mUserProfileProvider);
                } else {
                    return null;
                }
            case TargetHR:
                workoutStep = mWorkoutStepProvider.getCurrentWorkoutStep();
                if (workoutStep == null) {
                    return null;
                }
                if (workoutStep.targetType == Activity.WORKOUT_STEP_TARGET_HEART_RATE) {
                    return ((workoutStep.targetValueLow + workoutStep.targetValueHigh) / 2) as Float;
                }
                return null;
            case TargetHRZone:
                workoutStep = mWorkoutStepProvider.getCurrentWorkoutStep();
                if (workoutStep == null) {
                    return null;
                }
                if (workoutStep.targetType == Activity.WORKOUT_STEP_TARGET_HEART_RATE) {
                    var targetHR = ((workoutStep.targetValueLow + workoutStep.targetValueHigh) / 2);
                    return getHeartRateZone(targetHR, mUserProfileProvider);
                }
                return null;

            default:
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
        default:
            return "?";
    }
}